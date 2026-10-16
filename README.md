# python-template

A [Copier](https://copier.readthedocs.io/) template for Python projects:
uv, Ruff, pytest, a dev container, pre-commit security hooks (Betterleaks,
Semgrep, actionlint, zizmor), CI on the template's one Python version, Trivy
dependency scanning, Dependabot, release-please versioning with GitHub
releases, and an `AGENTS.md` for coding agents such as Claude Code.

## Create a project

```bash
uvx copier copy --trust gh:<owner>/python-template ~/projects/my-project
```

Replace `<owner>` with the GitHub user or organization hosting this template.
`gh:` is Copier's shorthand for `https://github.com/`; any git URL works too.
For a private repository, Copier fetches with your git credentials (e.g. after
`gh auth setup-git`).

It asks a few questions:

| Question | Notes |
| --- | --- |
| `project_name` | lowercase-with-hyphens; the package is the same with underscores |
| `description` | one line |
| `flavor` | `base`, or `browser` (adds Chrome + xvfb to the dev container) |
| `author_name`, `author_email`, `github_owner` | no defaults in the template; set your own (below) |

### Your defaults

The template holds no personal details. To skip retyping yours, put them in
Copier's settings file, `settings.yml`, in your platform's config folder:

| Platform | Settings file |
| --- | --- |
| Linux (including WSL) | `~/.config/copier/settings.yml` (or under `$XDG_CONFIG_HOME`) |
| macOS | `~/Library/Application Support/copier/settings.yml` |
| Windows | `%USERPROFILE%\AppData\Local\copier\settings.yml` |

Or point the `COPIER_SETTINGS_PATH` environment variable at a file anywhere.
Copier reads the file on the system where it runs, so under WSL that's the
Linux path inside WSL.

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

## Update a project from the template

Inside a generated project (committed, clean working tree):

```bash
uvx copier update --trust
```

Copier re-applies the template at its newest tag, three-way merging with your
changes. To change an answer at the same time, e.g. switch flavor:
`uvx copier update --trust -A -d flavor=browser`.

## Working on the template

See [CONTRIBUTING.md](CONTRIBUTING.md): how the template is laid out, trying a
change locally, CI, Renovate, releases, and adding a flavor.
