---
name: thai-cookbook-detailing
description: Get details and recipes from a Thai cookbook in the library
allowed-tools: Bash
user-invocable: true
argument-hint: <book-key>
---

# Thai Cookbook Details

## Purpose

Retrieve details and recipes from a Thai cookbook in the library.

## Utility scripts

Run the script using the skill's base directory (provided in the skill invocation header):

```bash
bash <base_directory>/scripts/thai-cook-book-details.sh $ARGUMENTS
```

Where `<base_directory>` is the path shown in "Base directory for this skill:" at the top of the skill invocation.

## Inputs

Required: book_key (string)

The key identifier for the cookbook.

## Output

Returns a JSON with the complete cookbook entry including info (de/en) and all recipes.

Available book keys:
- thailand_das_kochbuch
- hawker_fare
- the_food_of_northern_thailand
- the_food_of_southern_thailand
- bangkok_von_she_simmers
- pok_pok
- pok_pok_noodles
- hot_thai_kitchen
- and more...

Run without arguments to see the full list.
