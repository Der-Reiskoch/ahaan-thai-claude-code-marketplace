---
name: thai-trans-parsing
description: Use a Thai transliteration to find Thai Food Dictionary Entries
allowed-tools: Bash
user-invocable: true
argument-hint: <transliteration>
---

# Transliteration Parsing Skill

## Purpose

Parse a Thai transliteration (romanized Thai) and find matching entries in the Thai Food Dictionary.

## Utility scripts

Run the script using the skill's base directory (provided in the skill invocation header):

```bash
bash <base_directory>/scripts/parse-transliteration.sh $ARGUMENTS
```

Where `<base_directory>` is the path shown in "Base directory for this skill:" at the top of the skill invocation.

## Inputs

Required: transliteration (string)

A romanized Thai term to look up (e.g. "Pad Thai" or "Gaeng Keow Wan")

## Output

Returns a JSON with the transliteration and meaning details from the Thai Food Dictionary
