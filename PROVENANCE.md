# Provenance

The hook implementations were adapted from public repositories. This repository contains generic behavior and newly written documentation; it does not include organization-specific wording or infrastructure configuration.

| Local files | Source revision | Adaptation |
| --- | --- | --- |
| `.pre-commit-hooks.yaml`, `scripts/check_shdoc.sh`, `tests/test_hooks.sh` | [`assembleiarr/ci-workflows@8ff012bc68c6c12c9083564dccd679a3b6edb8e5`](https://github.com/assembleiarr/ci-workflows/commit/8ff012bc68c6c12c9083564dccd679a3b6edb8e5) | Generalized the hook interfaces and rewrote the documentation and tests for this repository. |
| `scripts/check_exec_bit.sh` | [`al-rr/platform-modules@f688c4fe97ea6569d3423819f854f1f880bbd000`](https://github.com/al-rr/platform-modules/commit/f688c4fe97ea6569d3423819f854f1f880bbd000); path-with-space correction informed by [`assembleiarr/ci-workflows@1c80f64625499b289df046fa15eb6e7c0c61dc47`](https://github.com/assembleiarr/ci-workflows/commit/1c80f64625499b289df046fa15eb6e7c0c61dc47) | Reworked as a standalone pre-commit hook and covered entrypoints, libraries, exceptions, and paths with spaces. |
| `.github/workflows/*.yml`, `.pre-commit-config.yaml`, `README.md`, `docs/operator-guide.md`, and other repository files | New work in this repository | Authored for this personal repository. The workflows use full-SHA action pins and minimal permissions. |

The test cases in `tests/test_hooks.sh` are written for this repository. They cover allowed example environment files, rejected real environment files, executable modes, shell headers, exceptions, and paths with spaces.
