# Changelog

## [0.13.0](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/compare/v0.12.2...v0.13.0) (2025-07-17)


### Features

* update ucs-base to 5.2.2-build.20250714 ([1aa906d](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/commit/1aa906d560139c6e1047ba0d956c892bd6a5e91f)), closes [univention/dev/internal/team-nubus#1320](https://git.knut.univention.de/univention/dev/internal/team-nubus/issues/1320)

## [0.12.2](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/compare/v0.12.1...v0.12.2) (2025-07-09)


### Bug Fixes

* make the helm chart entrpoint in the udm-listener redundant ([1834158](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/commit/1834158f5446517231c26acd0c6b68144d186f39)), closes [univention/dev/internal/dev-issues/dev-incidents#149](https://git.knut.univention.de/univention/dev/internal/dev-issues/dev-incidents/issues/149)

## [0.12.1](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/compare/v0.12.0...v0.12.1) (2025-06-23)


### Bug Fixes

* bump umc-base-image version ([bd724f5](https://git.knut.univention.de/univention/dev/nubus-for-k8s/listener-base/commit/bd724f5675b86df57b903bfd1bfa5b542e9bfa81)), closes [univention/dev/internal/team-nubus#1263](https://git.knut.univention.de/univention/dev/internal/team-nubus/issues/1263)

## [0.12.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.11.1...v0.12.0) (2025-05-11)


### Features

* move and upgrade ucs-base-image to 0.17.3-build-2025-05-11 ([a0d5b64](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/a0d5b64bf1f95879112dc821e6985c5623d2c713))

## [0.11.1](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.11.0...v0.11.1) (2025-05-10)


### Bug Fixes

* move addlicense pre-commit hook ([47e082c](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/47e082c8bbf0e3ece685ea82dc840880a6148984))
* update common-ci to main ([3cf99fe](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/3cf99feed547447b38781c9fc714a7e35958b46e))

## [0.11.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.10.2...v0.11.0) (2025-04-28)


### Features

* Bump ucs-base-image version ([678591c](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/678591c9b56b6b032496ec539f78fea7c601bc8b)), closes [univention/dev/internal/team-nubus#1155](https://git.knut.univention.de/univention/dev/internal/team-nubus/issues/1155)

## [0.10.2](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.10.1...v0.10.2) (2025-04-14)


### Bug Fixes

* upgrade common dependency to 0.12.2 ([0a34aa2](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/0a34aa254a940d0007a1cfa2c3c3de8808bc6352))

## [0.10.1](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.10.0...v0.10.1) (2025-02-28)


### Bug Fixes

* make sed call in entrypoint idempotent (univention/customers/dataport/upx/container-listener-base[#3](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/issues/3)) ([e3ec0d9](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/e3ec0d9795fbd5ca859528a5a0cf19a45d5e75f8))

## [0.10.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.9.0...v0.10.0) (2025-02-26)


### Features

* Bump ucs-base-image to use released apt sources ([e421a50](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/e421a509fd39cf7ffa84b4cc1ce9bb4a18710122))

## [0.9.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.8.0...v0.9.0) (2024-12-20)


### Features

* upgrade UCS base image to 2024-12-12 ([ec59f35](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/ec59f35ec44955d8aaac545418a3bed31b877a2e))

## [0.8.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.7.0...v0.8.0) (2024-09-13)


### Features

* update UCS base image to 2024-09-09 ([8042512](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/8042512a9d9e4283032a62110b1dd8b84c266307))

## [0.7.0](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/compare/v0.6.0...v0.7.0) (2024-05-07)


### Features

* Log a message on startup also when TLS mode is disabled ([7fa9a74](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/7fa9a74a2298ed43d6875fda67c54d0503c62e51))


### Bug Fixes

* Remove TLS_START_TLS_FLAGS ([86552fd](https://git.knut.univention.de/univention/customers/dataport/upx/container-listener-base/commit/86552fdb19ca9baa2c1cfdde9cfb512ade6204bc))

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
