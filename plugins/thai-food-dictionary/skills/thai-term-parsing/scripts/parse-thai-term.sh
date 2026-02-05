
#!/usr/bin/env bash

# Self-locating: resolve the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

set -euo pipefail

DICT_URL="https://www.ahaan-thai.de/api/thai-food-dictionary.json"

[ "$#" -ne 1 ] && exit 1

INPUT="$1"
DICT_JSON="$(curl -s "$DICT_URL" | jq 'reduce .[] as $item ({}; . + $item)')"

KEYS=()
while IFS= read -r key; do
  KEYS+=("$key")
done < <(
  echo "$DICT_JSON" |
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
    if [[ "$REMAINING" == "$KEY"* ]]; then
      VALUE="$(echo "$DICT_JSON" | jq -c --arg k "$KEY" '.[$k]')"
      [ "$FIRST" -eq 0 ] && echo ","
      FIRST=0
      printf '  "%s": %s' "$KEY" "$VALUE"
      REMAINING="${REMAINING#"$KEY"}"
      MATCHED=1
      break
    fi
  done

  if [ "$MATCHED" -eq 0 ]; then
    CHAR="${REMAINING:0:1}"
    [ "$FIRST" -eq 0 ] && echo ","
    FIRST=0
    printf '  "%s": null' "$CHAR"
    REMAINING="${REMAINING:1}"
  fi
done

echo
echo "}"
