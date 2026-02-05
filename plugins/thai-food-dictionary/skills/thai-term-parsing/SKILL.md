---
name: thai-term-parsing
description: Parse a Thai Term and return the parts with translitations and meanings in german and english
allowed-tools: Bash
user-invocable: true
argument-hint: <thai_string>
---

# Thai Term Parser

## Purpose

Lexicon-based segmentation of a Thai string into the longest matching dictionary entries from a remote JSON dictionary. Each segment is mapped to its dictionary entry or null if no entry exists.

## Utility scripts

Run the script using the skill's base directory (provided in the skill invocation header):

```bash
bash <base_directory>/scripts/parse-thai-term.sh $ARGUMENTS
```

Where `<base_directory>` is the path shown in "Base directory for this skill:" at the top of the skill invocation.

## Inputs

Required : thai_string (string, UTF-8)

A Thai text without word separators (e.g. เมี่ยงปลาแซลมอน)

## Requirements

- curl
- jq
- Network access to dictionary endpoint

## External Resource

Dictionary URL
https://www.ahaan-thai.de/api/thai-food-dictionary.json

Dictionary Schema
{
"<thai_term>": {
"thai": "<thai_term>",
"trans_de": "German Tranliteration",
"trans_en": "English Tranliteration",
"meaning_de": "German Meaning",
"meaning_en": "English Meaning"
}
}

Keys are Thai strings. Values are metadata objects.
