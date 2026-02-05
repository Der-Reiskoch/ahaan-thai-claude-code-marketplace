# ahaan-thai-claude-code-marketplace

ahaan-thai Marketplace for Claude Code plugins - a collection of tools for working with Thai food and recipes.

See the [Plugins Reference](https://code.claude.com/docs/en/plugins-reference) for general information on Claude Plugins.

## Design Philosophy

This marketplace prioritizes **script-based skills over MCP servers**. MCP servers consume context even when not being used - their tool definitions are always loaded into the conversation. Script-based skills are more efficient as they only add to context when explicitly invoked.

An MCP server fallback plugin is available for cases where context usage is not a concern and full MCP flexibility is needed.

## Available Plugins

| Plugin                     | Description                                              |
| -------------------------- | -------------------------------------------------------- |
| `thai-food-dictionary`     | Thai food dictionary skills                              |
| `thai-food-encyclopedia`   | Thai food encyclopedia skills                            |
| `thai-cook-book-library`   | Thai cookbook library skills                             |
| `ahaan-thai-mcp-servers`   | MCP servers fallback (use when context is not a concern) |
| `khao-pad-dev-mcp-servers` | Recommended MCP servers for khao-pad based web dev       |
| `khao-pad-dev-skills`      | Khao-pad web development skills (UI components & CSS)    |

## Installation

### Add the Marketplace

```bash
claude plugin marketplace add https://github.com/Der-Reiskoch/ahaan-thai-claude-code-marketplace
```

### Install a Plugin

```bash
claude plugin install thai-food-dictionary@ahaan-thai-plugins --scope project
claude plugin install thai-food-encyclopedia@ahaan-thai-plugins --scope project
claude plugin install thai-cook-book-library@ahaan-thai-plugins --scope project
```

Or for the MCP fallback (when context usage doesn't matter):

```bash
claude plugin install ahaan-thai-mcp-servers@ahaan-thai-plugins --scope project
```

Or for the khao-pad web development MCP servers:

```bash
claude plugin install khao-pad-dev-mcp-servers@ahaan-thai-plugins --scope project
```

Or for khao-pad web development skills (UI components & CSS styling):

```bash
claude plugin install khao-pad-dev-skills@ahaan-thai-plugins --scope project
```

## Tests (Live Endpoints)

```bash
bash scripts/tests/run-live-smoke-tests.sh
```
