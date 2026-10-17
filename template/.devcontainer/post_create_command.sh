#!/bin/bash
# Shebang: tells the system to execute this script using bash

# Exit immediately if any command fails (prevents partial setup)
# This ensures the development environment is either fully set up or fails clearly
set -e

# Display status message to user during container setup
echo "Setting up development environment..."

# The ~/.claude directory is backed by a named volume (see devcontainer.json)
# so Claude Code history/memory survives rebuilds. Named volumes mount
# root-owned on first creation, so hand ownership to the vscode user.
sudo chown -R vscode:vscode /home/vscode/.claude 2>/dev/null || true

# Install all dependencies (including the dev group and any optional extras)
# from pyproject.toml and uv.lock into ~/.venv (UV_PROJECT_ENVIRONMENT, see the
# Dockerfile). --locked fails loudly if the lock is out of sync rather than
# silently re-resolving, so the container matches CI exactly.
uv sync --locked --all-extras

# Browser automation (the browser flavor, or any project that depends on
# Playwright): download the Chromium build matching the locked Playwright
# version, plus the Linux libraries it needs to launch. `uv sync` can't do
# this, since the browser isn't a Python package; without it, a run fails at
# launch with "Executable doesn't exist". --with-deps installs the libraries
# with apt through sudo, which the vscode user has.
if uv run --no-sync python -c "import playwright" 2>/dev/null; then
    uv run --no-sync playwright install --with-deps chromium
fi

# Enable the repo's git hooks (.githooks/pre-commit runs the checks in
# .pre-commit-config.yaml on every commit). The setting lives in .git/config,
# which the host shares, so commits made outside the container are checked
# too. Skipped, not fatal, when git can't use the workspace (the current
# directory, where postCreateCommand runs): it isn't a checkout (e.g. a
# downloaded zip), or git refuses it (e.g. "dubious ownership" on a bind
# mount); git's own message is printed so the cause is visible.
if git_error=$(git rev-parse --git-dir 2>&1 >/dev/null); then
    git config core.hooksPath .githooks
else
    echo "Skipping git hook setup: ${git_error}"
fi

# Install the Claude Code plugins that .claude/settings.json enables.
# enabledPlugins only switches a plugin on; it doesn't download it, so without
# this Claude Code reports it as "enabled but not installed". The official
# marketplace is normally added on Claude Code's first interactive start, which
# hasn't happened yet in a new container, so add it first. Both steps are
# no-ops once done (~/.claude persists across rebuilds), and failures (e.g. no
# network) only print a warning: the plugins can be installed later with
# `claude plugin install <plugin> --scope project`.
if command -v claude >/dev/null 2>&1 && [ -f .claude/settings.json ]; then
    if ! marketplace_error=$(claude plugin marketplace add anthropics/claude-plugins-official </dev/null 2>&1); then
        echo "Warning: couldn't add the claude-plugins-official marketplace: ${marketplace_error}"
    fi
    python3 -c 'import json; print("\n".join(k for k, v in json.load(open(".claude/settings.json")).get("enabledPlugins", {}).items() if v))' \
        | while read -r plugin; do
            claude plugin install "$plugin" --scope project </dev/null \
                || echo "Warning: couldn't install Claude Code plugin ${plugin}."
        done
fi

# Configure shell activation for all future terminal sessions so the project's
# virtualenv is active in every new terminal. Guarded so a missing venv is not
# fatal.
echo 'source "$UV_PROJECT_ENVIRONMENT/bin/activate" 2>/dev/null || true' >> ~/.bashrc

# Display completion message to user
echo "Setup complete! New terminals activate the project's virtualenv."
