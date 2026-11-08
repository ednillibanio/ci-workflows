# Operator guide

This public repository provides versioned pre-commit hooks and reusable GitHub Actions workflows for personal application repositories. Do not add secrets or organization-specific infrastructure details.

## Install hooks in a consumer repository

Add the hooks to its `.pre-commit-config.yaml` and pin a published tag:

```yaml
repos:
  - repo: https://github.com/ednillibanio/ci-workflows
    rev: vX.Y.Z
    hooks:
      - id: sem-env
      - id: check-exec-bit
      - id: check-shdoc
```

Run `pre-commit install` once per clone and `pre-commit run --all-files` to validate all tracked files. `.env.example` and `.env.prod.example` are allowed; real environment files are rejected. Shell hooks require Bash and Git.

## Call reusable workflows

Use full commit SHAs when calling workflows, and pass only the inputs documented in each workflow's `workflow_call` declaration. For the initial workflow set, pin commit `d9e8db92a2a88f5a69460d9d635bc25adf37432e`. Use `pull_request` callers without secrets. Each workflow checks out `github.repository`, which is the caller repository in the called workflow context. Restrict caller permissions to the minimum required. `.github/workflows/test-callers.yml` exercises each reusable workflow on pull requests to `main` and can also be run with `workflow_dispatch`; the PR-title caller runs on its documented pull-request event types.

Workflows cover hygiene, history-wide secret scanning, pull request titles, Maven tests, pnpm build/lint/test, Semgrep, Trivy dependency scanning and separate backend/frontend CycloneDX SBOM artifacts. Findings in SAST and dependency scans are informational initially; scanner execution errors should fail the job.

## Develop and validate

From the repository root, run:

```sh
./tests/test_hooks.sh
pre-commit run --all-files
```

The hook tests create disposable Git repositories and check passing and failing cases. YAML syntax and workflow semantics should be checked with `actionlint` before review. CI validates the same hook tests. A green local test does not prove a GitHub-hosted reusable workflow works; invoke the test callers and inspect their outputs and artifacts.

## Version and troubleshooting

After review and required checks pass, version hooks with SemVer tags. Consumers pin immutable tags for pre-commit hooks and full commit SHAs for Actions workflows. Never move or delete a published tag.

- Hook fetch fails: check GitHub access and the pinned tag or SHA.
- `.env` is rejected: keep real values in ignored local files or a secret store; only the documented example names are permitted.
- Executable-bit check fails: entrypoints need Git mode `100755`; sourced libraries should be `100644`.
- shdoc check fails: add `@file`, `@brief`, `@description`, and `@example` to the header of the executable script.
- Scanner findings appear: inspect the report and track findings; distinguish them from scanner startup or infrastructure failures.
- SBOM artifact is missing: inspect the Trivy step and confirm the corresponding backend/frontend path exists in the caller.

The first tagged hook release is `v0.1.0`. GitHub-hosted test callers validate the reusable workflows in this repository; validation in a real sapl-next consumer PR remains for stage 03 of the personal app foundation.
