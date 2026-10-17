# python-template

Go from zero to a working, secure Python project in one command, fully set
up and ready to code. One [Copier](https://copier.readthedocs.io/)
command and a few questions give you a repo that's ready to push: modern
Python tooling, security checks that run on their own, a ready-made dev
container, and guardrails for coding agents like
[Claude Code](https://code.claude.com/docs). Building browser automation?
Pick the `browser` add-on for Playwright, set up and tested. When the template
improves, `copier update` brings the changes into your existing projects.

## Out of the box functionality

- **Modern Python tooling, already configured.** A small set of fast,
  standard tools: [uv](https://docs.astral.sh/uv/) manages Python versions,
  the virtualenv, and dependencies in one tool, and
  [Ruff](https://docs.astral.sh/ruff/) formats and lints in one pass. Tests
  run with [pytest](https://docs.pytest.org/), with unit and integration
  tests kept separate. Projects target the latest Python release, and the
  template moves to each new one. The same Python, tools, and checks
  ([pre-commit](https://pre-commit.com/)) run locally and in CI
  ([GitHub Actions](https://docs.github.com/actions)), so what passes locally
  passes in CI.
- **Secure by default, fully automatic.** Every commit is checked
  automatically for secrets
  ([Betterleaks](https://github.com/betterleaks/betterleaks)), code issues
  ([Semgrep](https://semgrep.dev/)), and workflow problems
  ([actionlint](https://github.com/rhysd/actionlint),
  [zizmor](https://docs.zizmor.sh/)), and CI runs the same checks (GitHub
  Actions). CI also scans the full git history for secrets and checks
  dependencies for known vulnerabilities ([Trivy](https://trivy.dev/)); Trivy
  and Semgrep re-run weekly to catch newly published CVEs and new rules.
  Every GitHub Action and hook is pinned to a commit SHA, and dependency
  updates wait 7 days after a release
  ([Dependabot](https://docs.github.com/code-security/dependabot) cooldown),
  so a hijacked release is usually caught before it reaches you.
- **A ready-made dev container (recommended).** Open the project in its
  [Dev Container](https://containers.dev/) and start coding. All you install
  is Docker and an editor that supports dev containers, such as VS Code:
  - **Everything set up:** dependencies installed from the lockfile, the
    virtualenv active in every terminal, commit hooks on, the
    `security-guidance` plugin installed, and, for the `browser` flavor,
    Playwright's Chromium ready to launch.
  - **Everything installed:** the project's Python, uv, the
    [GitHub CLI](https://cli.github.com/), and the Claude Code CLI, which
    keeps itself up to date.
  - **A safer place for Claude Code to work:** it sees only the project,
    keeping the rest of your machine's files, credentials, and local
    services out of reach.
  - **VS Code ready:** the Python, Pylance, Ruff, and TOML extensions, with
    the project's interpreter selected.
  - **Log in to Claude Code once:** its login, history, and memory are kept
    across rebuilds and shared by every project made from this template.
  - **Tested every week:** CI builds and starts the container for every
    flavor, so it keeps working when something it downloads changes.

  Prefer your own setup? The project runs anywhere with uv and git.
- **Coding agent ready.** [`AGENTS.md`](https://agents.md/) tells agents how
  the project works: its commands and rules, read by Claude Code and other
  agents. Claude Code settings (`.claude/settings.json`) keep an over-eager
  agent in check:
  - telemetry and error reporting off, and commits and PRs credited to you
    alone;
  - `.env` files and the credential files in your home folder (SSH, GitHub
    CLI, cloud, `.netrc`, `.pypirc`, Docker) kept off-limits;
  - a prompt before every commit, push, PR create/merge/close, release or
    repo deletion, and git command that discards work, even in auto mode;
  - the
    [`security-guidance`](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/security-guidance)
    plugin, installed by the dev container.

  These guard against an over-eager agent's mistakes; see "Claude Code" in
  the generated `CONTRIBUTING.md` for the details and limits.
- **Automated releases.** Pull request titles
  ([Conventional Commits](https://www.conventionalcommits.org/), checked on
  every PR) drive the version, changelog, and GitHub release
  ([release-please](https://github.com/googleapis/release-please)), with the
  built package attached. Versioning and tagging happen automatically.
- **Every pull request checked, every dependency kept current.** Lint,
  tests, and the security hooks run on every pull request and roll up into
  one status check; make it required in branch protection so only passing
  changes merge. Dependency, action, and hook updates arrive as weekly pull
  requests (Dependabot), grouped to keep the noise down.
- **Configuration new developers can find.** A committed `.env.example`
  lists every variable the application reads at run time, with what each is
  for, so setting up is one copy (`cp .env.example .env`) and filling in
  values. Real values live only in `.env`, which git ignores and Claude Code
  keeps off-limits.
- **Always current.** The template follows its own rules:
  [Renovate](https://docs.renovatebot.com/) keeps its pinned versions current,
  and CI (GitHub Actions) generates and tests a project, dev container
  included, on every change and every week. Existing projects pick up the
  improvements with one command (`copier update`).

### Add-on: browser automation

Choose the `browser` flavor when you create a project (or switch an existing
one with `copier update`), and it comes with
[Playwright](https://playwright.dev/python/) and Chromium, set up and tested,
plus a working example to start from:

- **Headed while you build it, headless once it works:** one switch, with
  the window maximized when headed and a desktop-size page when headless.
- **Stop and look:** pause a run to inspect the page, or open Playwright's
  Inspector to step through it and try out selectors.
- **Replay any run:** record a trace and step back through every action,
  with the page, screenshots, and network at each one.
- **Browser tests in CI:** pytest-playwright tests that build their own
  pages, run headless on every pull request, and can be watched with
  `--headed`.

## Getting started

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
| `flavor` | `base`, or `browser` (adds Playwright browser automation: Chromium, example code, and tests) |
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
