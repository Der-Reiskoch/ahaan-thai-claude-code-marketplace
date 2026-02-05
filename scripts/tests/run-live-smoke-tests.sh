#!/usr/bin/env bash
set -euo pipefail

require_bin() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_bin curl
require_bin jq
require_bin python3

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

curl_json() {
  curl -fsS "$1"
}

echo "Running live smoke tests..."

DICT_URL="https://www.ahaan-thai.de/api/thai-food-dictionary.json"
ENC_URL_DE="https://www.ahaan-thai.de/api/thai-food-encyclopedia.json"
ENC_URL_EN="https://en.ahaan-thai.de/api/thai-food-encyclopedia.json"
COOKBOOK_URL="https://www.ahaan-thai.de/api/thai-cook-book-library.json"

DICT_JSON="$(curl_json "$DICT_URL")"
DICT_MAP="$(echo "$DICT_JSON" | jq 'reduce .[] as $item ({}; . + $item)')"

TERM_TH="$(echo "$DICT_MAP" | jq -r 'keys[0]')"
if [ -z "$TERM_TH" ] || [ "$TERM_TH" = "null" ]; then
  echo "Failed to pick a Thai term from dictionary" >&2
  exit 1
fi

TRANS_TERM="$(echo "$DICT_MAP" | jq -r '
  to_entries[]
  | .value as $v
  | [
      ($v.trans_de // "" | split(", ")),
      ($v.trans_en // "" | split(", ")),
      ($v.trans_alt // "" | split(", "))
    ] | add
  | map(gsub("^ +| +$"; "") | ascii_downcase)
  | map(select(length > 1))
  | .[]
' | head -n1)"
if [ -z "$TRANS_TERM" ] || [ "$TRANS_TERM" = "null" ]; then
  echo "Failed to pick a transliteration term from dictionary" >&2
  exit 1
fi

ENC_DE_JSON="$(curl_json "$ENC_URL_DE")"
ENC_TERM="$(echo "$ENC_DE_JSON" | jq -r '.[] | select((.transcription // "") != "") | .transcription' | head -n1)"
if [ -z "$ENC_TERM" ] || [ "$ENC_TERM" = "null" ]; then
  ENC_TERM="$(echo "$ENC_DE_JSON" | jq -r '.[] | select((.thaiName // "") != "") | .thaiName' | head -n1)"
fi
if [ -z "$ENC_TERM" ] || [ "$ENC_TERM" = "null" ]; then
  echo "Failed to pick an encyclopedia term" >&2
  exit 1
fi

COOKBOOK_KEY="$(curl_json "$COOKBOOK_URL" | jq -r 'keys[0]')"
if [ -z "$COOKBOOK_KEY" ] || [ "$COOKBOOK_KEY" = "null" ]; then
  echo "Failed to pick a cookbook key" >&2
  exit 1
fi

echo "- thai-term-parser"
TERM_OUT="$(bash plugins/thai-food-dictionary/skills/thai-term-parsing/scripts/parse-thai-term.sh "$TERM_TH")"
echo "$TERM_OUT" | jq -e --arg k "$TERM_TH" 'has($k)' >/dev/null

echo "- thai-transliteration-parser"
TRANS_OUT="$(bash plugins/thai-food-dictionary/skills/thai-transliteration-parser/scripts/parse-transliteration.sh "$TRANS_TERM")"
echo "$TRANS_OUT" | jq -e --arg k "$TRANS_TERM" '.[$k] != null' >/dev/null

echo "- thai-food-encyclopedia-finder"
ENC_OUT="$(bash plugins/thai-food-encyclopedia/skills/thai-food-encyclopedia-finder/scripts/find-in-thai-food-enyclopedia.sh "$ENC_TERM")"
echo "$ENC_OUT" | jq -e '((.de | length) > 0) or ((.en | length) > 0)' >/dev/null

# Ping EN endpoint once to catch outages separate from the script logic.
# The script only uses both endpoints internally, so keep this lightweight.
_="$(curl_json "$ENC_URL_EN" | jq -e 'type == "array"' >/dev/null)"

echo "- thai-cook-book-details"
COOK_OUT="$(bash plugins/thai-cook-book-library/skills/thai-cook-book-details/scripts/thai-cook-book-details.sh "$COOKBOOK_KEY")"
echo "$COOK_OUT" | jq -e --arg k "$COOKBOOK_KEY" '.book_key == $k' >/dev/null

echo "- ask-clickthai"
CLICK_OUT="$(bash plugins/thai-tools/skills/ask-clickthai/scripts/ask-clickthai.sh "som tam")"
echo "$CLICK_OUT" | jq -e 'type == "object"' >/dev/null

echo "All live smoke tests passed."
