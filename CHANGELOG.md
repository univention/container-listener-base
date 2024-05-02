# Changelog

## [0.6.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.5.1...v0.6.0) (2024-05-02)


### Features

* Update base image to 5.0-7 version 0.12.0 ([7be9b30](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/7be9b309bca15502fc1729bcd840477bd7fdd70b))


### Bug Fixes

* Avoid calling "apt-get update" to leverage the packages from the base image ([991e1ad](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/991e1addc313a488a151ea0db77d662c30d29251))
* Change UCR variable "uldap/start-tls" to "directory/manager/starttls" ([5bccb32](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/5bccb32d6301945ac562c55713e5f524319b2cf3))
* Drop uldap patch ([15d1cc8](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/15d1cc8b901e329c70cd252330d56e83fbf2ea7e))
* Update C code patches to 5.0-7 ([38f5788](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/38f57884950719e94dab9a80fcb958a7ecc0c9ee))

## [0.5.1](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.5.0...v0.5.1) (2024-01-31)


### Bug Fixes

* **deps:** update all dependencies ([3e114aa](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/3e114aa57843d6d766ccbbe435390e0f4f17a288))

## [0.5.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.4.7...v0.5.0) (2024-01-16)


### Features

* **ci:** add debian update check jobs for scheduled pipeline ([5b8bb46](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/5b8bb4615ce50e04caf7512960703e3279b0a21d))


### Bug Fixes

* **deps:** add renovate.json ([2bcc26b](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/2bcc26b6eb4d0f6a8004a82fbfe026f4f7353501))

## [0.4.7](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.4.6...v0.4.7) (2023-12-28)


### Bug Fixes

* **licensing/ci:** add spdx license headers, add license header checking pre-commit ([81ba796](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/81ba796c60e1ed153c67d6a28f3ada8562bc1cb0))

## [0.4.6](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.4.5...v0.4.6) (2023-12-20)


### Bug Fixes

* **docker:** update ucs-base from 5.0-5 to 5.0-6 ([e2f955f](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/e2f955fe70f7ddcb375dfec26091c600a27f06bf))

## [0.4.5](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.4.4...v0.4.5) (2023-12-19)


### Bug Fixes

* **ci:** add Helm chart signing and publishing to souvap via OCI ([2aaed25](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/2aaed25f9e9d679069898c7f4273b40e6b9dea7b))
* **ci:** add Helm chart signing and publishing to souvap via OCI, common-ci 1.12.x ([f28411f](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/f28411fa683051cc348406919329dd3c604394b9))

## [0.4.4](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.4.3...v0.4.4) (2023-12-07)


### Bug Fixes

* **ci:** reference common-ci aniemann/push-sbom-signatures-to-souvap-351 ([ebc7428](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/ebc7428fe548129caa5238c6c5471debfb2a1329))
