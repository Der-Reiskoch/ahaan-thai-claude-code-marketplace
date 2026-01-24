# Repository Guidelines

## Core Principle: Minimize Context Usage

**Do NOT create MCP servers for new functionality.** MCP servers consume context even when they are not being used - their tool definitions are always loaded into every conversation. This wastes tokens and reduces the effective context window for actual work.

Instead, use **script-based skills**:
- Shell scripts (`.sh`) or Python scripts (`.py`) that call external APIs
- `SKILL.md` files that define when and how to use the scripts
- Only invoked when explicitly needed, keeping context clean

The `ahaan-thai-mcp-servers` plugin exists as a fallback for users who don't care about context usage and need full MCP flexibility. MCP servers work well and are more flexible than tailored scripts, but they always consume context even when idle. The `khao-pad-dev-mcp-servers` plugin provides Recommended MCP servers for khao-pad based web dev.

## Project Structure & Module Organization

- `.claude-plugin/marketplace.json` defines the marketplace entries and published plugin metadata.
- `plugins/` holds individual plugins; each plugin has `.claude-plugin/plugin.json`.
- `plugins/*/skills/` contain skill definitions (`SKILL.md`) and their supporting scripts.
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
- Add skills in `skills/<skill-name>/SKILL.md` with scripts under `skills/<skill-name>/scripts/`.
- **Do NOT add `.mcp.json`** - use script-based skills instead to minimize context usage.
- Update `.claude-plugin/marketplace.json` so the new plugin is discoverable.
- Add a short install or usage note in `README.md` if the plugin is user-facing.

## Security & Configuration Tips

- External calls are made via `curl`; document any new endpoints and keep API usage to read-only.
- Keep scripts self-contained and POSIX-friendly.
