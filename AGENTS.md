# AGENTS.md

Instructions for coding agents working on this repository: a
[Copier](https://copier.readthedocs.io/) template for Python projects. Full
detail for humans is in [CONTRIBUTING.md](CONTRIBUTING.md).

## What goes where

- `template/` is what new projects get. Files ending in `.jinja` are rendered
  (suffix dropped); everything else is copied verbatim.
- In `.jinja` files, Jinja uses `[[ var ]]`, `[% ... %]`, and `[# ... #]`, not
  `{{ }}`: `${{ }}` in GitHub Actions workflows must pass through untouched.
  A file that needs no variables should not be `.jinja`.
- Questions are in `copier.yml`. Keep them few: add a `flavor` choice rather
  than a new yes/no question, and no personal defaults (names, emails, GitHub
  owners) anywhere in the template.
- Root files (`.github/`, `.pre-commit-config.yaml`, this file, ...) belong to
  the template repo and are not copied.
- `template/AGENTS.md.jinja` is the generated project's agent guide; keep it
  in step when changing commands or conventions under `template/`.

## Checking a change

Check changes to `template/` on a generated project, since that is what CI
tests:

```bash
dest="$(mktemp -d)/demo-project"
uvx copier copy --trust --defaults --vcs-ref HEAD \
  --data-file .github/ci-answers.yml . "$dest"
cd "$dest"
uv run ruff format --check . && uv run ruff check . && uv run pytest
git add -A && SKIP=betterleaks uv run pre-commit run --all-files
```

For root files, run this repo's hooks:
`uvx --python 3.14 pre-commit run --all-files`.

## Conventions

- Pin GitHub Actions and pre-commit hook revs to full commit SHAs with the
  version in a trailing comment (`@<sha> # vX.Y.Z`, `rev: <sha> # frozen:
  vX.Y.Z`); Renovate updates both.
- Comments explain why, not what. Match the surrounding comment style.
- PR titles use Conventional Commits; they drive template releases, and
  `copier update` only reaches projects through a release. So a change to
  anything under `template/` takes a releasable type even when it's only
  documentation: `feat` for something new in projects, `fix` for a
  correction, `build`/`ci` for dependency and workflow changes. Use `docs`,
  `chore`, `refactor`, `style`, or `test` only for changes outside
  `template/`; they don't cut a release.
- Squash merges use the PR title as the commit subject and an empty body. To
  add a footer (`Release-As: X.Y.Z`, or a `BREAKING CHANGE:` explanation),
  pass it at merge time with `gh pr merge <n> --squash --body "..."`; footers
  in the PR description don't carry over.
