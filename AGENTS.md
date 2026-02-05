# Repository Guidelines

## Basic Rules

- Ask questions if anything is uncertain, do not make any assumptions!
- Ask those questions in a numbered List, so that the user can address them easily
- plan before you implement!
- do not commit anything without permission by the user
- update your internal documentation after you finished a task

## Core Principle: Minimize Context Usage

**Do NOT create MCP servers for new functionality.** MCP servers consume context even when they are not being used - their tool definitions are always loaded into every conversation. This wastes tokens and reduces the effective context window for actual work.

Instead, use **skills**:

- **Script-based skills**: Shell scripts (`.sh`) or Python scripts (`.py`) that call external APIs, with `SKILL.md` files that define when and how to use them
- **Knowledge-based skills**: `SKILL.md` files with reference documentation in a `resources/` subdirectory that provide guidelines and constraints
- Both types are only invoked when explicitly needed, keeping context clean

The `ahaan-thai-mcp-servers` plugin exists as a fallback for users who don't care about context usage and need full MCP flexibility. MCP servers work well and are more flexible than tailored scripts, but they always consume context even when idle. The `khao-pad-dev-mcp-servers` plugin provides Recommended MCP servers for khao-pad based web dev. The `khao-pad-dev-skills` plugin provides knowledge-based skills for khao-pad web development, covering Khao UI components and CSS styling with the Khao Malet design system.

## Project Structure & Module Organization

- `.claude-plugin/marketplace.json` defines the marketplace entries and published plugin metadata.
- `plugins/` holds individual plugins; each plugin has `.claude-plugin/plugin.json`.
- `plugins/*/skills/` contain skill definitions (`SKILL.md`) and their supporting scripts (`scripts/`) or reference documentation (`resources/`).
- `README.md` documents how to install the marketplace and example plugins.

## Build, Test, and Development Commands

This repo is configuration- and script-driven; there is no centralized build or test runner.

- `bash plugins/thai-food-dictionary/skills/thai-term-parsing/scripts/parse-thai-term.sh "pad thai"` parses a Thai term using the dictionary API (requires `curl` and `jq`).

## Coding Style & Naming Conventions

- Use Markdown for instructions (`SKILL.md`, `README.md`) and JSON for plugin metadata (`.claude-plugin/plugin.json`, `.mcp.json`).
- Shell scripts use `bash` with `set -euo pipefail`; keep them POSIX-friendly and self-contained.
- Naming: plugin folders use kebab-case, skill folders use kebab-case (`thai-term-parser`), and scripts live under `skills/<skill>/scripts/`.

## Testing Guidelines

- Run the live smoke tests with `bash scripts/tests/run-live-smoke-tests.sh` (requires `curl`, `jq`, and `python3`).
- If adding new scripts, include a short usage example in the associated `SKILL.md`.

## Commit & Pull Request Guidelines

- Commit messages in history are short, lowercase, and past-tense (e.g., "added ask-clickthai plugin"). Keep messages concise and action-oriented.
- PRs should describe the plugin or skill change, list any new external dependencies, and include sample command output when scripts change.

## Adding a New Plugin (Checklist)

- Create `plugins/<plugin-name>/` and add `.claude-plugin/plugin.json` with name, version, and description.
- Add skills in `skills/<skill-name>/SKILL.md` with scripts under `skills/<skill-name>/scripts/` or reference docs under `skills/<skill-name>/resources/`.
- **Do NOT add `.mcp.json`** - use skills instead to minimize context usage.
- Update `.claude-plugin/marketplace.json` so the new plugin is discoverable.
- Add a short install or usage note in `README.md` if the plugin is user-facing.

## Security & Configuration Tips

- External calls are made via `curl`; document any new endpoints and keep API usage to read-only.
- Keep scripts self-contained and POSIX-friendly.
