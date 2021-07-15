#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# pylint: disable=invalid-name

"""Build script for gitlab-ci"""

# included
import glob
import os
import shutil
import sys

# third party
import sh  # pylint: disable=import-error

# internal imports
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
LIBS_DIR = os.path.join(BASE_DIR, 'lib')
sys.path.insert(1, LIBS_DIR)

import ci_docker  # noqa: E402,E501; pylint: disable=import-error,wrong-import-position
from ci_log import (  # noqa: E402,E501; pylint: disable=import-error,wrong-import-position
    log,
)
import ci_vars  # noqa: E402,E501; pylint: disable=import-error,wrong-import-position
import ci_version  # noqa: E402,E501; pylint: disable=import-error,wrong-import-position

# pylint: disable=not-callable
sh_out = sh(_out='/dev/stdout', _err='/dev/stderr', _cwd=BASE_DIR)


def main():
    """The main script builds, labels and pushes"""

    envs = ci_vars.get_docker_envs(BASE_DIR, pull_push=True, compose=True)

    docker_compose_build_files = os.environ.get(
        'DOCKER_COMPOSE_BUILD_FILES',
        ci_vars.DEFAULT_DOCKER_COMPOSE_BUILD_FILES,
    )

    ci_pipeline_id = envs['compose']['CI_PIPELINE_ID']

    upx_image_registry = os.environ.get(
        'UPX_IMAGE_REGISTRY',
        ci_vars.DEFAULT_UPX_IMAGE_REGISTRY,
    )

    for old_name in glob.iglob('.env.*.example'):
        new_name = old_name.replace('.example', '')
        shutil.copy2(old_name, new_name)

    sh_out.docker_compose(
        docker_compose_build_files.split(),
        'build',
        _env=envs['compose'],
    )

    image_path = '{}container-listener-base/listener'.format(
        upx_image_registry
    )
    try:
        # push tag "<version>-<ci-pipeline-id>"
        ci_docker.add_and_push_build_version_label_and_tag(
            image_path, ci_pipeline_id, envs['docker'], envs['pull_push']
        )
    except ci_version.AppVersionNotFound:
        log.error('app version not found')
        return 2
    except ci_docker.DockerPushFailed:
        log.error('docker push failed')
        return 3

    # push tag "build-<ci-pipeline-id>"
    sh_out.docker_compose(
        docker_compose_build_files.split(),
        'push',
        _env=envs['compose'],
    )

    return 0


if __name__ == '__main__':
    sys.exit(main())

# [EOF]
