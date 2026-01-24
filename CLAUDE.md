# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

**Specialized MCP servers**: The `khao-pad-dev-mcp-servers` plugin provides Recommended MCP servers for khao-pad based web dev.

## Architecture

### Marketplace Structure

```
.claude-plugin/marketplace.json    # Marketplace definition with available plugins
plugins/                           # Individual plugin directories
  └── <plugin-name>/
      ├── .claude-plugin/plugin.json  # Plugin metadata
      ├── commands/                   # Slash commands (markdown files)
      └── skills/                     # User-invocable skills
          └── <skill-name>/
              ├── SKILL.md            # Skill definition with instructions
              └── scripts/            # Shell/Python scripts for API calls
```

### Available Plugins

| Plugin                     | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `thai-tools`               | Thai language tools skills                                         |
| `thai-food-dictionary`     | Thai food dictionary skills                                        |
| `thai-food-encyclopedia`   | Thai food encyclopedia skills                                      |
| `thai-cook-book-library`   | Thai cookbook library skills                                       |
| `ahaan-thai-mcp-servers`   | MCP servers fallback (use when context is not a concern)           |
| `khao-pad-dev-mcp-servers` | Recommended MCP servers for khao-pad based web dev |

### Plugin Structure

Each plugin uses script-based skills:

- **Commands**: `commands/<name>.md` - Simple slash commands
- **Skills**: `skills/<name>/SKILL.md` - Skills with instructions and scripts in `scripts/` subdirectory
- **Scripts**: Shell (`.sh`) or Python (`.py`) scripts that call external APIs

### Key Files

- `marketplace.json`: Defines available plugins with name, version, source path, and description
- `plugin.json`: Each plugin's metadata (name, description, version)
- `SKILL.md`: Skill definitions with YAML frontmatter (description, argument-hint) and instructions
- `.mcp.json`: MCP server configurations (only for fallback plugin)
