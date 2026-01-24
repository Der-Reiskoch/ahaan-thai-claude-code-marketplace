# ahaan-thai-claude-code-marketplace

ahaan-thai Marketplace for Claude Code plugins - a collection of tools for working with Thai food and recipes.

See the [Plugins Reference](https://code.claude.com/docs/en/plugins-reference) for general information on Claude Plugins.

## Design Philosophy

This marketplace prioritizes **script-based skills over MCP servers**. MCP servers consume context even when not being used - their tool definitions are always loaded into the conversation. Script-based skills are more efficient as they only add to context when explicitly invoked.

An MCP server fallback plugin is available for cases where context usage is not a concern and full MCP flexibility is needed.

## Available Plugins

| Plugin                   | Description                                                          |
| ------------------------ | -------------------------------------------------------------------- |
| `thai-tools`             | General Thai language skills (e.g., ask-clickthai dictionary lookup) |
| `thai-food-dictionary`   | Thai food term lookups via ahaan-thai.de                             |
| `thai-food-encyclopedia` | Thai food encyclopedia access                                        |
| `thai-cook-book-library` | Thai cookbook and recipe library                                     |
| `ahaan-thai-mcp-servers` | MCP servers fallback (use when context is not a concern)             |

## Installation

### Add the Marketplace

```bash
/plugin marketplace add https://github.com/Der-Reiskoch/ahaan-thai-claude-code-marketplace
```

### Install a Plugin

```bash
/plugin install thai-tools
/plugin install thai-food-dictionary
/plugin install thai-food-encyclopedia
/plugin install thai-cook-book-library
```

Or for the MCP fallback (when context usage doesn't matter):

```bash
/plugin install ahaan-thai-mcp-servers
```
