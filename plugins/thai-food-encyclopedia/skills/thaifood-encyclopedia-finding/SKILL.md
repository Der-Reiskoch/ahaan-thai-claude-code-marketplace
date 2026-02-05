---
name: thaifood-encyclopedia-finding
description: Find Entries in the Thai Food Encyclopedia
allowed-tools: Bash
user-invocable: true
argument-hint: <transliteration, summary, thainame or alternative names>
---

# Thai Food Encyclopedia Finder

## Purpose

Search for entries in the Thai Food Encyclopedia by transliteration, summary, Thai name, or alternative names.

## Utility scripts

Run the script using the skill's base directory (provided in the skill invocation header):

```bash
bash <base_directory>/scripts/find-in-thai-food-enyclopedia.sh $ARGUMENTS
```

Where `<base_directory>` is the path shown in "Base directory for this skill:" at the top of the skill invocation.

## Inputs

Required: search_term (string)

A transliteration, summary, Thai name, or alternative name to search for (e.g. "Pad Thai" or "ผัดไทย")

## Output

Returns a JSON with the complete entry from the Thai Food Encyclopedia
