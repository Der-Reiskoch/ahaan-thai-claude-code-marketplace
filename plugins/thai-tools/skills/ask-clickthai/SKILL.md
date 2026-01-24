---
name: ask-clickthai
description: Translate a Thai term into german using clickthai
allowed-tools: Bash
user-invocable: true
argument-hint: <thai_string>
---

# Ask Clickthai Skill

## Purpose

Query clickthai.com for transliteration and meaning of Thai terms in German.

## Utility scripts

Run the script using the skill's base directory (provided in the skill invocation header):

```bash
bash <base_directory>/scripts/ask-clickthai.sh $ARGUMENTS
```

Where `<base_directory>` is the path shown in "Base directory for this skill:" at the top of the skill invocation.

## Inputs

Required: thai_string (string, UTF-8)

A Thai term to look up (e.g. ผัดไทย)

## Output

Returns a JSON with the transliteration and meaning details from clickthai
