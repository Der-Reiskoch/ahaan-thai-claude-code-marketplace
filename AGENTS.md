# Repository Guidelines

## Project Structure & Module Organization

- `.claude-plugin/marketplace.json` defines the marketplace entries and published plugin metadata.
- `plugins/` holds individual plugins; each plugin has `.claude-plugin/plugin.json` and optional config such as `.mcp.json` for MCP servers.
- `plugins/thai-tools/skills/` and `plugins/thai-food-dictionary/skills/` contain skill definitions (`SKILL.md`) and their supporting scripts.
- `README.md` documents how to install the marketplace and example plugins.

## Build, Test, and Development Commands

This repo is configuration- and script-driven; there is no centralized build or test runner.

- `bash plugins/thai-food-dictionary/skills/thai-term-parser/scripts/parse-thai-term.sh "pad thai"` parses a Thai term using the dictionary API (requires `curl` and `jq`).
- `bash plugins/thai-tools/skills/ask-clickthai/scripts/ask-clickthai.sh "som tam"` queries ClickThai and outputs JSON (requires `curl` and `python3`).

## Coding Style & Naming Conventions

- Use Markdown for instructions (`SKILL.md`, `README.md`) and JSON for plugin metadata (`.claude-plugin/plugin.json`, `.mcp.json`).
- Shell scripts use `bash` with `set -euo pipefail`; keep them POSIX-friendly and self-contained.
- Naming: plugin folders use kebab-case (`thai-tools`), skill folders use kebab-case (`thai-term-parser`), and scripts live under `skills/<skill>/scripts/`.

## Testing Guidelines

- There is no automated test suite. Validate changes by running the relevant scripts and ensuring JSON outputs parse correctly.
- If adding new scripts, include a short usage example in the associated `SKILL.md`.

## Commit & Pull Request Guidelines

- Commit messages in history are short, lowercase, and past-tense (e.g., "added ask-clickthai plugin"). Keep messages concise and action-oriented.
- PRs should describe the plugin or skill change, list any new external dependencies, and include sample command output when scripts change.

## Adding a New Plugin (Checklist)

- Create `plugins/<plugin-name>/` and add `.claude-plugin/plugin.json` with name, version, and description.
- For MCP servers, add or update `plugins/<plugin-name>/.mcp.json` and keep it consistent with the plugin metadata.
- For skills, add `skills/<skill-name>/SKILL.md` and keep scripts under `skills/<skill-name>/scripts/`.
- Update `.claude-plugin/marketplace.json` so the new plugin is discoverable.
- Add a short install or usage note in `README.md` if the plugin is user-facing.

## Security & Configuration Tips

- External calls are made via `curl`; document any new endpoints and keep API usage to read-only.
- Prefer updating `.mcp.json` and plugin metadata in lockstep when adding or removing MCP servers.
