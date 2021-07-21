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
import ci_vars  # noqa: E402; pylint: disable=import-error,wrong-import-position
import ci_version  # noqa: E402,E501; pylint: disable=import-error,wrong-import-position

# pylint: disable=not-callable
sh_out = sh(_out='/dev/stdout', _err='/dev/stderr', _cwd=BASE_DIR)


def main():
    """The main script builds, labels and pushes"""

    image_name = 'upx-listener-base'

    envs = ci_vars.get_docker_envs(BASE_DIR, pull_push=True, compose=True)

    for old_name in glob.iglob('.env.*.example'):
        new_name = old_name.replace('.example', '')
        shutil.copy2(old_name, new_name)

    sh_out.docker_compose(
        envs['common']['DOCKER_COMPOSE_BUILD_FILES'].split(),
        'build',
        _env=envs['compose'],
    )

    try:
        # push tags "build-<ci-pipeline-id>" and "<version>-<ci-pipeline-id>"
        ci_docker.add_and_push_build_version_label_and_tag(
            image_name,
            envs['common']['CI_PIPELINE_ID'],
            envs['docker'],
            envs['pull_push'],
        )
    except ci_version.AppVersionNotFound:
        log.error('app version not found')
        return 2
    except ci_docker.DockerPushFailed:
        log.error('docker push failed')
        return 3

    return 0


if __name__ == '__main__':
    sys.exit(main())

# [EOF]
