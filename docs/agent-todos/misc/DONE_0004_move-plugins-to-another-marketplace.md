---
title: Move plugins to another marketplace
status: done
---

## Context

We have two plugins `plugins/todo-skills` and `plugins/skill-sharing` that do not fit in this specialized market place, so we want to move the to more general purpose marketplace

## Tasks

- [x] We prepared an empty repo `~/Projects/foodie/ji-agent-skills`
- [x] Make this a new repo a marketplace (see .claude-plugin as a template)
- [x] The name should be `ji-agent-skills`
- [x] Move both plugins/todo-skills`and`plugins/skill-sharing` to the new marketplace repo
- [x] Register them in the new marketplace
- [x] Remove any traces in the current repo
- [x] Update all documentation files that reference `plugins/todo-skills` and `plugins/skill-sharing`
- [x] Update the new marketplace`s README.md (use our README.md as a template)

## Progress, Decisions etc.

### 2026-02-05: Migration Completed

**What was done:**

- Created `.claude-plugin/marketplace.json` in ji-agent-skills with proper plugin definitions for todo-skills and skill-sharing
- Copied both plugins from ahaan-thai-claude-code-marketplace to ji-agent-skills/plugins/
- Removed both plugins from ahaan-thai-claude-code-marketplace
- Updated `.claude-plugin/marketplace.json` in ahaan-thai-claude-code-marketplace to remove the two plugins
- Updated README.md in ahaan-thai-claude-code-marketplace to remove plugin references
- Updated CLAUDE.md in ahaan-thai-claude-code-marketplace to remove plugin references from the Available Plugins table
- Created comprehensive README.md in ji-agent-skills marketplace with installation and usage instructions

**Final state:**

- ahaan-thai-claude-code-marketplace: Now contains only Thai food-related plugins (thai-food-dictionary, thai-food-encyclopedia, thai-cook-book-library, ahaan-thai-mcp-servers, khao-pad-dev-mcp-servers, khao-pad-dev-skills)
- ji-agent-skills: Now contains agent workflow plugins (todo-skills, skill-sharing)
- Both marketplaces have proper marketplace.json configurations
- All documentation updated in both repositories
