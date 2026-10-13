# Repository Guidelines

## Basic Rules

- Ask questions if anything is uncertain, do not make any assumptions!
- Ask those questions in a numbered List, so that the user can address them easily
- for complex tasks, plan before you implement!
- do not commit anything without permission by the user
- update your internal documentation after you finished a task

## Overview

This is a plugin marketplace for Claude Code and Codex containing plugins for working with Thai food and recipes. The plugins can be installed via the plugin systems of both tools (see `README.md`).

## Core Principle: Minimize Context Usage

**Do NOT create MCP servers for new functionality.** MCP servers consume context even when they are not being used - their tool definitions are always loaded into every conversation. This wastes tokens and reduces the effective context window for actual work.

Instead, use **skills**:

- **Script-based skills**: Shell scripts (`.sh`) or Python scripts (`.py`) that call external APIs, with `SKILL.md` files that define when and how to use them
- **Knowledge-based skills**: `SKILL.md` files with reference documentation in a `resources/` subdirectory that provide guidelines and constraints
- Both types are only invoked when explicitly needed, keeping context clean

**MCP servers as fallback**: The existing `ahaan-thai-mcp-servers` plugin is kept as a fallback option. MCP servers work well and offer more flexibility than tailored scripts. Use them when:

- Context and token usage are not a concern
- You need the full flexibility of the MCP protocol
- Script-based skills would be too limiting for the use case

## Project Structure & Module Organization

```bash
.claude-plugin/marketplace.json    # Marketplace definition for Claude Code
.agents/plugins/marketplace.json   # Marketplace definition for Codex
plugins/                           # Individual plugin directories
  └── <plugin-name>/
      ├── .claude-plugin/plugin.json  # Plugin metadata (Claude Code)
      ├── .codex-plugin/plugin.json   # Plugin metadata (Codex)
      ├── commands/                   # Slash commands (markdown files)
      └── skills/                     # User-invocable skills
          └── <skill-name>/
              ├── SKILL.md            # Skill definition with instructions
              ├── scripts/            # Shell/Python scripts for API calls
              └── resources/          # Reference documentation (Markdown)
scripts/tests/                     # Live smoke tests
README.md                          # Installation and plugin overview
```

Each plugin provides its functionality in one of these patterns:

- **Commands**: `commands/<name>.md` - Simple slash commands
- **Script-based skills**: `skills/<name>/SKILL.md` with executable scripts in `scripts/` subdirectory (Shell `.sh` or Python `.py`)
- **Knowledge-based skills**: `skills/<name>/SKILL.md` with reference documentation in `resources/` subdirectory (Markdown `.md`)

### Key Files

- `marketplace.json`: Defines available plugins with name, version, source path, and description
- `plugin.json`: Each plugin's metadata (name, description, version)
- `SKILL.md`: Skill definitions with YAML frontmatter (description, argument-hint) and instructions
- `.mcp.json`: MCP server configurations (only for the fallback plugin)

### Available Plugins

| Plugin                   | Description                                              | Skills                                           |
| ------------------------ | -------------------------------------------------------- | ------------------------------------------------ |
| `thai-food-dictionary`   | Thai food dictionary skills                              | `thai-term-parsing`, `thai-trans-parsing`        |
| `thai-food-encyclopedia` | Thai food encyclopedia skills                            | `thaifood-encyclopedia-finding`                  |
| `thai-cook-book-library` | Thai cookbook library skills                             | `thai-cookbook-detailing`                        |
| `ahaan-thai-mcp-servers` | MCP servers fallback (use when context is not a concern) | — (hosted MCP server for all three data sources) |

## Skills

### Naming Convention

When creating or renaming skills (slash commands), use the **noun + gerund** pattern:

- Format: `[noun]-[gerund]` (e.g., `term-parsing`, `entry-finding`)
- The noun describes the subject/object being acted upon
- The gerund (-ing form used as noun: parsing, finding, importing) describes the action

This convention applies to all **plugin skills** in `plugins/<plugin-name>/skills/` directories.

**Examples:**

- `term-parsing` - parsing Thai food terms
- `transliteration-parsing` - parsing Thai transliterations
- `encyclopedia-finding` - finding encyclopedia entries
- `cookbook-browsing` - browsing cookbook references
- `todo-importing` - importing todos from GitHub issues
- `todo-processing` - processing agent todo files
- `css-styling` - styling with CSS
- `component-rendering` - rendering UI components

**Avoid:**

- Verb-first names: ~~`parse-term`~~, ~~`find-entry`~~, ~~`search-dictionary`~~
- Agent-style names: ~~`term-parser`~~, ~~`encyclopedia-finder`~~, ~~`cookbook-details`~~
- Plain verbs: ~~`translate`~~, ~~`search`~~, ~~`lookup`~~
- Preposition patterns: ~~`style-with-css`~~, ~~`ask-clickthai`~~

## Build, Test, and Development Commands

This repo is configuration- and script-driven; there is no centralized build or test runner.

- `bash plugins/thai-food-dictionary/skills/thai-term-parsing/scripts/parse-thai-term.sh "pad thai"` parses a Thai term using the dictionary API (requires `curl` and `jq`).

## Coding Style & Naming Conventions

- Use Markdown for instructions (`SKILL.md`, `README.md`) and JSON for plugin metadata (`plugin.json`, `marketplace.json`, `.mcp.json`).
- Shell scripts use `bash` with `set -euo pipefail`; keep them POSIX-friendly and self-contained.
- Naming: plugin folders use kebab-case, skill folders use kebab-case following the skill naming convention above (`thai-term-parsing`), and scripts live under `skills/<skill>/scripts/`.

## Testing Guidelines

- Run the live smoke tests with `bash scripts/tests/run-live-smoke-tests.sh` (requires `curl`, `jq`, and `python3`).
- If adding new scripts, include a short usage example in the associated `SKILL.md`.

## Commit & Pull Request Guidelines

- Commit messages in history are short, lowercase, and past-tense (e.g., "added ask-clickthai plugin"). Keep messages concise and action-oriented.
- PRs should describe the plugin or skill change, list any new external dependencies, and include sample command output when scripts change.

## Adding a New Plugin (Checklist)

- Create `plugins/<plugin-name>/` and add `.claude-plugin/plugin.json` and `.codex-plugin/plugin.json` with name, version, and description.
- Add skills in `skills/<skill-name>/SKILL.md` with scripts under `skills/<skill-name>/scripts/` or reference docs under `skills/<skill-name>/resources/`.
- **Do NOT add `.mcp.json`** - use skills instead to minimize context usage.
- Update `.claude-plugin/marketplace.json` and `.agents/plugins/marketplace.json` so the new plugin is discoverable.
- Add a short install or usage note in `README.md` if the plugin is user-facing.
- When changing an existing plugin, bump its version in both `plugin.json` files and both `marketplace.json` files.

## Security & Configuration Tips

- External calls are made via `curl`; document any new endpoints and keep API usage to read-only.
- Keep scripts self-contained and POSIX-friendly.
