#!/usr/bin/env bash

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

set -euo pipefail

DICT_URL="https://www.ahaan-thai.de/api/thai-food-dictionary.json"

[ "$#" -ne 1 ] && exit 1

INPUT="$1"
DICT_JSON="$(curl -s "$DICT_URL" | jq 'reduce .[] as $item ({}; . + $item)')"

# Create a map from transliteration (lowercase) to the Thai word
TRANS_TO_THAI_MAP=$(echo "$DICT_JSON" | jq '
. as $dict |
reduce keys[] as $thai_word ({};
    . +
    (if $dict[$thai_word].trans_de and ($dict[$thai_word].trans_de | length > 0) then
        [($dict[$thai_word].trans_de | split(", ") | .[] | { ( . | ascii_downcase | sub("^ +"; "") | sub(" +$"; "")): $thai_word })] | add
     else {} end) +
    (if $dict[$thai_word].trans_en and ($dict[$thai_word].trans_en | length > 0) then
        [($dict[$thai_word].trans_en | split(", ") | .[] | { ( . | ascii_downcase | sub("^ +"; "") | sub(" +$"; "")): $thai_word })] | add
     else {} end) +
    (if $dict[$thai_word].trans_alt and ($dict[$thai_word].trans_alt | length > 0) then
        [($dict[$thai_word].trans_alt | split(", ") | .[] | { ( . | ascii_downcase | sub("^ +"; "") | sub(" +$"; "")): $thai_word })] | add
     else {} end)
)')

KEYS=()
while IFS= read -r key; do
  # Filter out very short keys that are likely to cause bad matches
  if [ "${#key}" -gt 1 ]; then
    KEYS+=("$key")
  fi
done < <(
  echo "$TRANS_TO_THAI_MAP" |
  jq -r 'keys[]' |
  awk '{ print length, $0 }' |
  sort -rn |
  cut -d" " -f2-
)

REMAINING="$INPUT"
FIRST=1

echo "{"

while [ -n "$REMAINING" ]; do
  MATCHED=0

  for KEY in "${KEYS[@]}"; do
    # Case-insensitive matching
    if [[ "$(echo "$REMAINING" | tr '[:upper:]' '[:lower:]')" == "$KEY"* ]]; then
      MATCHED_PART="${REMAINING:0:${#KEY}}"
      THAI_WORD=$(echo "$TRANS_TO_THAI_MAP" | jq -r --arg k "$KEY" '.[$k]')
      VALUE=$(echo "$DICT_JSON" | jq -c --arg k "$THAI_WORD" '.[$k]')
      
      [ "$FIRST" -eq 0 ] && echo ","
      FIRST=0
      
      printf '  "%s": %s' "$MATCHED_PART" "$VALUE"
      
      REMAINING="${REMAINING:${#KEY}}"
      MATCHED=1
      break
    fi
  done

  if [ "$MATCHED" -eq 0 ]; then
    CHAR="${REMAINING:0:1}"
    if [[ "$CHAR" =~ [[:space:]] ]]; then
      # If it's a whitespace, just skip it and don't print anything
      REMAINING="${REMAINING:1}"
    else
      # If it's not a whitespace and not matched, print as null
      [ "$FIRST" -eq 0 ] && echo ","
      FIRST=0
      printf '  "%s": null' "$CHAR"
      REMAINING="${REMAINING:1}"
    fi
  fi
done

echo
echo "}"
