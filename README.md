# python-template

A [Copier](https://copier.readthedocs.io/) template for Python projects:
uv, Ruff, pytest, a dev container, pre-commit security hooks (Betterleaks,
Semgrep, actionlint, zizmor), CI on the template's one Python version, Trivy
dependency scanning, Dependabot, and release-please versioning with GitHub
releases.

## Create a project

```bash
uvx copier copy --trust gh:rsforbes/python-template ~/projects/my-project
```

It asks a few questions:

| Question | Notes |
| --- | --- |
| `project_name` | lowercase-with-hyphens; the package is the same with underscores |
| `description` | one line |
| `flavor` | `base`, or `browser` (adds Chrome + xvfb to the dev container) |
| `author_name`, `author_email`, `github_owner` | no defaults in the template; set your own (below) |

### Your defaults

The template holds no personal details. To skip retyping yours, put them in
Copier's settings file, `~/.config/copier/settings.yml` (Linux; run
`uvx copier --help` and see "settings" for macOS/Windows paths):

```yaml
defaults:
  author_name: Your Name
  author_email: you@example.com
  github_owner: your-github-user
# Templates allowed to run tasks without --trust. A URL ending in "/" trusts
# everything under it; a local path must match exactly, as an absolute path.
trust:
  - gh:your-github-user/
```

They become the suggested answers; you just press Enter.

`--trust` lets the template run its setup tasks in the new project:
`git init`, `uv lock`, and `uv sync`. Without it Copier refuses to run them.
Then follow "First push" in the new project's README.

From a local clone instead of GitHub, add `--vcs-ref HEAD` to use your latest
commit rather than the latest tag:

```bash
uvx copier copy --trust --vcs-ref HEAD ~/projects/python-template ~/projects/my-project
```

## Update a project from the template

Inside a generated project (committed, clean working tree):

```bash
uvx copier update --trust
```

Copier re-applies the template at its newest tag, three-way merging with your
changes. To change an answer at the same time, e.g. switch flavor:
`uvx copier update --trust -A -d flavor=browser`.

## Working on the template

- Everything under `template/` is copied into new projects. Files ending in
  `.jinja` are rendered (the suffix is dropped); everything else is copied
  as-is.
- Template variables use `[[ var ]]` and `[% if ... %]` instead of Jinja's
  usual `{{ }}`, because GitHub Actions workflows are full of `${{ }}`.
- Questions live in `copier.yml`. Prefer adding a `flavor` choice over a new
  yes/no question.
- Every project targets one Python version, `python_version` in `copier.yml`
  (3.14). When a new Python ships, bump it there (check the dev container image
  has a matching tag, see `template/.devcontainer/Dockerfile.jinja`), tag the
  template, and run `copier update` in each project.
- Tag a release (`git tag v0.2.0 && git push --tags`) so `copier update` in
  existing projects picks it up; Copier uses tags, not the branch head.
- CI (`.github/workflows/template-ci.yml`) generates projects and runs their
  lint, tests, and workflow checks, and builds and starts each flavor's dev
  container. It also runs weekly, since the Dockerfile downloads things that
  can break without a commit. Its answers are in `.github/ci-answers.yml`.

### Adding a flavor

1. Add a choice to `flavor` in `copier.yml`.
2. Guard flavor-specific content in `.jinja` files with
   `[% if flavor == 'name' %] ... [% endif %]`.
3. Add the flavor to the `devcontainer` job's matrix in `template-ci.yml`,
   plus any checks for what it installs.
