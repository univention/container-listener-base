#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# pylint: disable=invalid-name

"""Build script for gitlab-ci"""

# included
import os
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

    envs = ci_vars.get_docker_envs(BASE_DIR, pull_push=True, compose=False)

    ci_pipeline_id = os.environ.get(
        'CI_PIPELINE_ID', ci_vars.DEFAULT_CI_PIPELINE_ID
    )

    upx_image_registry = os.environ.get(
        'UPX_IMAGE_REGISTRY',
        ci_vars.DEFAULT_UPX_IMAGE_REGISTRY,
    )
    upx_image_name = 'container-listener-base/listener'
    upx_image_path = '{}{}'.format(upx_image_registry, upx_image_name)

    try:
        # push tags "latest" and "<version>"
        ci_docker.pull_add_push_publish_version_tag(
            upx_image_path,
            ci_pipeline_id,
            envs['docker'],
            envs['pull_push'],
        )
    except ci_version.AppVersionNotFound:
        log.error('app version not found')
        return 2
    except ci_docker.DockerPullFailed:
        log.error('docker pull failed')
        return 1
    except ci_docker.DockerPushFailed:
        log.error('docker push failed')
        return 3

    return 0


if __name__ == '__main__':
    sys.exit(main())

# [EOF]
