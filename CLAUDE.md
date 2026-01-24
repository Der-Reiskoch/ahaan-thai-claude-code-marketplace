# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Claude Code marketplace repository containing plugins for working with Thai food and recipes. The marketplace provides plugins that can be installed via Claude Code's plugin system.

## Architecture

### Marketplace Structure

```
.claude-plugin/marketplace.json    # Marketplace definition with available plugins
plugins/                           # Individual plugin directories
  ├── thai-tools/                  # Skills and commands plugin
  │   ├── .claude-plugin/plugin.json
  │   ├── commands/                # Slash commands (markdown files)
  │   └── skills/                  # User-invocable skills with SKILL.md
  └── ahaan-thai-mcp-servers/      # MCP servers plugin
      ├── .claude-plugin/plugin.json
      └── .mcp.json                # MCP server definitions
```

### Plugin Types

1. **Skills Plugin (thai-tools)**: Contains commands and skills defined via markdown files
   - Commands: `commands/<name>.md` - Simple slash commands
   - Skills: `skills/<name>/SKILL.md` - Skills with optional scripts in `scripts/` subdirectory

2. **MCP Servers Plugin (ahaan-thai-mcp-servers)**: Adds MCP servers (thai-food-dictionary, thai-food-encyclopedia, thai-cookbook-library) via `.mcp.json`

### Key Files

- `marketplace.json`: Defines available plugins with name, version, source path, and description
- `plugin.json`: Each plugin's metadata (name, description, version)
- `SKILL.md`: Skill definitions with YAML frontmatter (description, argument-hint) and instructions
- `.mcp.json`: MCP server configurations

## Scripts

- `.scripts/parse-thai-term.sh`: Parses Thai terms using the ahaan-thai.de dictionary API
- `plugins/thai-tools/skills/ask-clickthai/scripts/ask-clickthai.sh`: Queries clickthai-online.de dictionary
