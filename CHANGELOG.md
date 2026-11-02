# Changelog

## [0.4.0](https://github.com/rsforbes/copier-python/compare/v0.3.1...v0.4.0) (2026-11-02)


### Features

* let Claude Code read and inspect without asking ([#32](https://github.com/rsforbes/copier-python/issues/32)) ([97912b9](https://github.com/rsforbes/copier-python/commit/97912b9d30e98f83b41ef31cc61a4b5d24ac24a7))
* support Azure DevOps as a hosting platform ([#29](https://github.com/rsforbes/copier-python/issues/29)) ([a877573](https://github.com/rsforbes/copier-python/commit/a877573e34fa512368b61e5305d9b803ab1cd78c))


### Bug Fixes

* keep Claude Code telemetry on so feature-flag features work ([#16](https://github.com/rsforbes/copier-python/issues/16)) ([bd188d2](https://github.com/rsforbes/copier-python/commit/bd188d279ab5e7add3221138b8ea56c961ce7a03))
* rename the template to copier-python ([#23](https://github.com/rsforbes/copier-python/issues/23)) ([394527d](https://github.com/rsforbes/copier-python/commit/394527db006bdf80b5a40101558d8e2187185695))
* share the Trivy gate and Betterleaks steps between GitHub and Azure CI ([#34](https://github.com/rsforbes/copier-python/issues/34)) ([d982ce5](https://github.com/rsforbes/copier-python/commit/d982ce5ed0c1b16beb48361f9308d95b11cf28f2))
* verify the dev container's uv and Claude Code downloads ([#33](https://github.com/rsforbes/copier-python/issues/33)) ([cb82865](https://github.com/rsforbes/copier-python/commit/cb82865ec026b8266024dcfc41af6003715dcc40))


### Continuous Integration

* **deps:** update dependency aquasecurity/trivy to v0.76.0 ([#18](https://github.com/rsforbes/copier-python/issues/18)) ([5493a45](https://github.com/rsforbes/copier-python/commit/5493a4571f73f947a97a66673fdd488971f78dff))
* **deps:** update dependency aquasecurity/trivy to v0.76.1 ([#26](https://github.com/rsforbes/copier-python/issues/26)) ([74d1e93](https://github.com/rsforbes/copier-python/commit/74d1e9342c9ffe189b8696658e3fa9990d2cba09))
* **deps:** update dependency semgrep/pre-commit to v1.182.1 ([#28](https://github.com/rsforbes/copier-python/issues/28)) ([ee5cf91](https://github.com/rsforbes/copier-python/commit/ee5cf9174f15a87410a30933a38bcc30489d961c))
* **deps:** update github actions ([#19](https://github.com/rsforbes/copier-python/issues/19)) ([3742b27](https://github.com/rsforbes/copier-python/commit/3742b275cdf5be97c12997de25dff04b5eba7a84))
* **deps:** update github actions ([#27](https://github.com/rsforbes/copier-python/issues/27)) ([9668519](https://github.com/rsforbes/copier-python/commit/96685193a5ff1b27d382782fd333dcc574dc191d))
* **deps:** update pre-commit hooks ([#20](https://github.com/rsforbes/copier-python/issues/20)) ([06a0f78](https://github.com/rsforbes/copier-python/commit/06a0f78ed1971be9bc5d920973ddfefe19fafed4))
* fail a PR's Trivy scan only on findings it introduces ([#22](https://github.com/rsforbes/copier-python/issues/22)) ([7de9741](https://github.com/rsforbes/copier-python/commit/7de974182472cdb49a00b13b54c117723515b0a9))

## [0.3.1](https://github.com/rsforbes/python-template/compare/v0.3.0...v0.3.1) (2026-10-19)


### Continuous Integration

* **deps:** update github actions ([8727b78](https://github.com/rsforbes/python-template/commit/8727b78765b7daadf0f9388591395ae42c7ab561))

## [0.3.0](https://github.com/rsforbes/python-template/compare/v0.2.0...v0.3.0) (2026-10-17)


### Features

* add Claude Code guardrails, .env.example, and Playwright browser flavor ([#8](https://github.com/rsforbes/python-template/issues/8)) ([939dc02](https://github.com/rsforbes/python-template/commit/939dc020e3172ad8051d13f1f44c94ed3671ae66))

## [0.2.0](https://github.com/rsforbes/python-template/compare/v0.1.2...v0.2.0) (2026-10-16)


### Features

* add AGENTS.md to generated projects ([#3](https://github.com/rsforbes/python-template/issues/3)) ([9d411df](https://github.com/rsforbes/python-template/commit/9d411df990e78f3863667d8fd892825109c80254))


### Documentation

* require a releasable PR type for changes under template/ ([#4](https://github.com/rsforbes/python-template/issues/4)) ([a0e5609](https://github.com/rsforbes/python-template/commit/a0e56096ddee02c62d45ef2d74fe69212ff67cac))

## [0.1.2](https://github.com/rsforbes/python-template/compare/v0.1.1...v0.1.2) (2026-10-15)


### Continuous Integration

* dogfood Renovate, pre-commit, and release-please in the template repo ([#1](https://github.com/rsforbes/python-template/issues/1)) ([8f1ee72](https://github.com/rsforbes/python-template/commit/8f1ee7298d0a60b6c65925f3c3c6ff6e68e936f7))
