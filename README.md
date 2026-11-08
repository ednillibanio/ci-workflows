# Personal CI workflows

Reusable pre-commit hooks and GitHub Actions workflows for personal application repositories maintained by ednillibanio. The repository is public and must not contain secrets, internal organization data, or organization-specific infrastructure details.

The first release, `v0.1.0`, provides `sem-env`, `check-exec-bit`, and `check-shdoc`. The repository also provides reusable GitHub Actions workflows. Pin hook consumers to a SemVer tag and workflow consumers to a full commit SHA; the initial workflow set is at `d9e8db92a2a88f5a69460d9d635bc25adf37432e`.

See [operator guide](docs/operator-guide.md) for installation, validation, release and troubleshooting instructions. See [provenance](PROVENANCE.md) for source material and adaptation notes.

Licensed under Apache License 2.0; see [LICENSE](LICENSE).
