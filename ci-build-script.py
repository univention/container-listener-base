#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# pylint: disable=invalid-name

"""Build script for gitlab-ci"""

# included
import glob
import logging
import os
import shutil
import sys
import time

# third party
import sh  # pylint: disable=import-error

# pylint: disable=not-callable
sh2 = sh(_out='/dev/stdout', _err='/dev/stderr')

DEFAULT_UPX_IMAGE_REGISTRY = 'artifacts.knut.univention.de/upx/'

DEFAULT_CI_PIPELINE_ID = 'none'

MINIMAL_DOCKER_VARS = ['DOCKER_HOST']

ADDITIONAL_PULL_PUSH_VARS = (
    'DBUS_SESSION_BUS_ADDRESS',
    'PATH',
)

ADDITIONAL_COMPOSE_VARS = (
    'CI_COMMIT_SHA',
    'CI_JOB_STARTED_AT',
    'CI_PIPELINE_ID',
    'CI_PROJECT_URL',
    'DBUS_SESSION_BUS_ADDRESS',
    'LANG',
    'PWD',
)

DEFAULT_DOCKER_COMPOSE_BUILD_FILES = (
    '--file docker-compose.yaml'
    ' --file docker-compose.override.yaml'
    ' --file docker-compose.prod.yaml'
)

logging.Formatter.converter = time.gmtime
logging.basicConfig(
    format='%(asctime)s %(levelname)-8s %(message)s',
    level=logging.DEBUG,
    datefmt='%Y-%m-%dT%H:%M:%SZ',
)


class AppVersionNotFound(Exception):
    """Raised if /version file could not be read"""


def get_app_version(image_name, docker_env):
    """Retrieves content of /version file from a container"""
    logging.info('Retrieving /version from {}'.format(image_name))
    result = sh2.docker.run(
        '--rm',
        '--entrypoint=/bin/cat',
        image_name,
        '/version',
        _env=docker_env,
        _out=None,
    ).stdout
    app_version = result.rstrip().decode('ascii')
    if not app_version:
        raise AppVersionNotFound
    return app_version


def add_version_label(app_version, image_name, docker_env):
    """Adds a version label to an image"""
    logging.info('Adding version label {}'.format(app_version))
    sh2.docker.build(
        '--label',
        'org.opencontainers.app.version={}'.format(app_version),
        '--tag',
        image_name,
        '-',
        _env=docker_env,
        _in='FROM {}'.format(image_name),
    )
    logging.info('Done with labeling')


def add_and_push_tag(image_name, tag, docker_env, pull_push_env):
    """Adds a tag to an image"""
    logging.info('Adding tag {} to {}'.format(tag, image_name))
    sh2.docker.tag(image_name, tag, _env=docker_env)
    sh2.docker.push(tag, _env=pull_push_env)
    logging.info('Done with this tag')


def get_env_vars(var_names):
    """Check for environmental variables and return them as a dict"""
    env_vars = {}
    for var_name in var_names:
        if var_name in os.environ:
            env_vars[var_name] = os.environ[var_name]
    return env_vars


def main():
    """The main script builds, labels and pushes"""

    docker_env = get_env_vars(MINIMAL_DOCKER_VARS)

    pull_push_env = get_env_vars(ADDITIONAL_PULL_PUSH_VARS)
    pull_push_env.update(docker_env)

    compose_env = {
        'COMPOSE_DOCKER_CLI_BUILD': '0',
        'CI_PROJECT_URL': 'unset',
        'CI_PIPELINE_ID': DEFAULT_CI_PIPELINE_ID,
        'LANG': 'C.UTF-8',
    }

    if 'CI_JOB_STARTED_AT' not in os.environ:
        compose_env['CI_JOB_STARTED_AT'] = time.strftime(
            "%Y-%m-%dT%H:%M:%SZ", time.gmtime()
        )

    if 'CI_COMMIT_SHA' not in os.environ:
        # pylint: disable=too-many-function-args
        compose_env['CI_COMMIT_SHA'] = (
            sh.git('rev-parse', 'HEAD').stdout.rstrip().decode('ascii')
        )

    compose_env.update(get_env_vars(ADDITIONAL_COMPOSE_VARS))
    compose_env.update(docker_env)

    docker_compose_build_files = os.environ.get(
        'DOCKER_COMPOSE_BUILD_FILES', DEFAULT_DOCKER_COMPOSE_BUILD_FILES
    )

    ci_pipeline_id = compose_env['CI_PIPELINE_ID']

    upx_image_registry = os.environ.get(
        'UPX_IMAGE_REGISTRY',
        DEFAULT_UPX_IMAGE_REGISTRY,
    )

    image_path = '{}container-listener-base/listener'.format(
        upx_image_registry
    )
    build_path = '{}:build-{}'.format(image_path, ci_pipeline_id)

    for old_name in glob.iglob('.env.*.example'):
        new_name = old_name.replace('.example', '')
        shutil.copy2(old_name, new_name)

    sh2.docker_compose(
        docker_compose_build_files.split(),
        'build',
        _env=compose_env,
    )

    try:
        app_version = get_app_version(build_path, docker_env)
    except AppVersionNotFound:
        return 2

    add_version_label(app_version, build_path, docker_env)

    logging.debug('pull_push_env {}'.format(pull_push_env))

    try:
        sh2.docker.push(build_path, _env=pull_push_env)
    except sh.ErrorReturnCode_1:  # pylint: disable=no-member
        logging.error('dock push failed')
        return 3

    clean_version = app_version.replace('~', '-')
    tag = '{}:{}-{}'.format(image_path, clean_version, ci_pipeline_id)
    add_and_push_tag(build_path, tag, docker_env, pull_push_env)

    sh2.docker_compose(
        docker_compose_build_files.split(),
        'push',
        _env=compose_env,
    )

    return 0


if __name__ == '__main__':
    sys.exit(main())

# [EOF]
