# Contributing to the template

This guide is for working on the template itself. To create or update a
project from it, see the [README](README.md).

## Setup

Requires [uv](https://docs.astral.sh/uv/). Enable the pre-commit hooks once per
clone:

```bash
git config core.hooksPath .githooks
```

## How the template is laid out

- Everything under `template/` is copied into new projects. Files ending in
  `.jinja` are rendered (the suffix is dropped); everything else is copied
  as-is.
- Template variables use `[[ var ]]` and `[% if ... %]` instead of Jinja's
  usual `{{ }}`, because GitHub Actions workflows are full of `${{ }}`.
- Questions live in `copier.yml`. Prefer adding a `flavor` choice over a new
  yes/no question.
- Files at the repo root (this one, `.github/`, `.pre-commit-config.yaml`, ...)
  belong to the template repo and are not copied.
- Every project targets one Python version, `python_version` in `copier.yml`
  (3.14). When a new Python ships, bump it there (check the dev container image
  has a matching tag, see `template/.devcontainer/Dockerfile.jinja`), release
  the template, and run `copier update` in each project.

## Claude Code

`.claude/settings.json` here matches `template/.claude/settings.json` (see
"Claude Code" in `template/CONTRIBUTING.md.jinja` for what it does), except
for the allowed commands. Keep the two in step. Install the enabled plugin
once per clone:

```bash
claude plugin install security-guidance@claude-plugins-official --scope project
```

## Trying a change

Generate a project from your working copy. `--vcs-ref HEAD` uses your latest
commit rather than the latest tag; uncommitted changes are included too
(Copier warns about them):

```bash
uvx copier copy --trust --vcs-ref HEAD . ~/projects/my-test-project
```

Then run the generated project's checks there:

```bash
cd ~/projects/my-test-project
uv run ruff check . && uv run pytest
git add -A && uv run pre-commit run --all-files
```

To check how a change lands in an existing project, run
`uvx copier update --trust --vcs-ref HEAD` inside a project generated from an
earlier version.

## CI

Template CI (`.github/workflows/template-ci.yml`) runs on every pull request:

- **Generate**: generates a project and runs its lint, tests, CLI, and
  pre-commit hooks, i.e. the template's files as rendered.
- **Dev container**: builds and starts each flavor's dev container and checks
  the tools inside it.
- **Template pre-commit hooks**: this repo's own hooks on its root files.
- **Betterleaks pin**: the generated CI's Betterleaks version and checksum
  (see Renovate below).

It also runs weekly, since the Dockerfile downloads things that can break
without a commit. Its answers are in `.github/ci-answers.yml`.

## Hooks, versions, and releases

The template repo uses the same tooling it gives projects:

- **Pre-commit hooks** (`.pre-commit-config.yaml`): Betterleaks, Semgrep,
  actionlint, and zizmor on the template's own files. Run them all with
  `uvx --python 3.14 pre-commit run --all-files`. actionlint checks `run:`
  scripts with shellcheck only when `shellcheck` is installed (CI has it).
- **PR titles** follow
  [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
  (`.github/workflows/pr-title.yml`). Pull requests are squash-merged, so the
  title becomes the commit on `main` and drives the version and changelog.
  A change under `template/` needs a releasable type (`feat`, `fix`, `build`,
  `ci`) even when it's only documentation, or it won't reach projects:
  `docs:` and `chore:` don't cut a release. The check fails a PR that changes
  `template/` under `docs`, `chore`, `refactor`, `style`, or `test`.
- **Renovate** (`.github/renovate.json5`) keeps the versions pinned under
  `template/` current: action SHAs (including in `.jinja` workflows), hook
  revs, dev dependency ranges, Trivy, Betterleaks, and the dev container
  feature. Each PR runs Template CI against a generated project. Betterleaks
  PRs need one manual step: push the new `BETTERLEAKS_SHA256` (from the
  release's `checksums.txt`) to the PR branch; the `betterleaks-pin` job fails
  until you do. Renovate runs as the
  [Renovate GitHub App](https://github.com/apps/renovate), installed on this
  repository.
- **Releases** (`.github/workflows/release.yml`): release-please keeps a
  release PR open; merging it tags the next version and writes `CHANGELOG.md`.
  `feat` bumps the minor version; `fix`, `perf`, `build`, and `ci` the patch.
  `copier update` in existing projects moves to the newest tag, not to main,
  so merge the release PR to ship template fixes.

## Adding a flavor

1. Add a choice to `flavor` in `copier.yml`.
2. Guard flavor-specific content in `.jinja` files with
   `[% if flavor == 'name' %] ... [% endif %]`. For a file only that flavor
   gets, put the condition in its name:
   `[% if flavor == 'name' %]file.py[% endif %]` (an empty name isn't
   created), plus `.jinja` only if its content uses variables. The `browser`
   flavor's `browser.py` and `test_browser.py.jinja` work this way.
3. Add the flavor to the `generate` and `devcontainer` jobs' matrices in
   `template-ci.yml`, plus any checks for what it installs.
