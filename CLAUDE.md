# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Basic Rules

- Ask questions if anything is uncertain, do not make any assumptions!
- Ask those questions in a numbered List, so that the user can address them easily
- for complex tasks, plan before you implement!
- do not commit anything without permission by the user
- update your internal documentation after you finished a task

## Skills Naming Convention

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

## Overview

This is a Claude Code marketplace repository containing plugins for working with Thai food and recipes. The marketplace provides plugins that can be installed via Claude Code's plugin system.

## Design Philosophy

**Script-based skills over MCP servers**: This project prioritizes script-based skills and commands instead of MCP servers. MCP servers consume context even when they are not being used - their tool definitions are always loaded into the conversation context. Script-based skills are more efficient as they only add to context when explicitly invoked.

When creating new plugins:

- Use shell scripts (`.sh`) or Python scripts to call external APIs
- Define skills via `SKILL.md` files with clear instructions
- Prefer script-based skills for new functionality

**MCP servers as fallback**: The existing MCP server plugin (`ahaan-thai-mcp-servers`) is kept as a fallback option. MCP servers work well and offer more flexibility than tailored scripts. Use them when:

- Context and token usage are not a concern
- You need the full flexibility of the MCP protocol
- Script-based skills would be too limiting for the use case

## Architecture

### Marketplace Structure

```bash
.claude-plugin/marketplace.json    # Marketplace definition with available plugins
plugins/                           # Individual plugin directories
  └── <plugin-name>/
      ├── .claude-plugin/plugin.json  # Plugin metadata
      ├── commands/                   # Slash commands (markdown files)
      └── skills/                     # User-invocable skills
          └── <skill-name>/
              ├── SKILL.md            # Skill definition with instructions
              ├── scripts/            # Shell/Python scripts for API calls
              └── resources/          # Reference documentation (Markdown)
```

### Available Plugins

| Plugin                     | Description                                              |
| -------------------------- | -------------------------------------------------------- |
| `thai-food-dictionary`     | Thai food dictionary skills                              |
| `thai-food-encyclopedia`   | Thai food encyclopedia skills                            |
| `thai-cook-book-library`   | Thai cookbook library skills                             |
| `ahaan-thai-mcp-servers`   | MCP servers fallback (use when context is not a concern) |

### Plugin Structure

Each plugin provides skills in one of two patterns:

- **Commands**: `commands/<name>.md` - Simple slash commands
- **Script-based skills**: `skills/<name>/SKILL.md` with executable scripts in `scripts/` subdirectory (Shell `.sh` or Python `.py`)
- **Knowledge-based skills**: `skills/<name>/SKILL.md` with reference documentation in `resources/` subdirectory (Markdown `.md`)

### Key Files

- `marketplace.json`: Defines available plugins with name, version, source path, and description
- `plugin.json`: Each plugin's metadata (name, description, version)
- `SKILL.md`: Skill definitions with YAML frontmatter (description, argument-hint) and instructions
- `.mcp.json`: MCP server configurations (only for fallback plugin)
