#!/usr/bin/env bash
set -euo pipefail

# --- Usage prüfen ---
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <searchTerm>"
  exit 1
fi

SEARCH_TERM=$(echo "$1" | xargs) # Trim leading/trailing whitespace

URL="https://www.clickthai-online.de/wbtde/woerterbuch.php"

PYTHON_SCRIPT_FILE="$(dirname "$0")/parse-clickthai.py"

# Use Python to parse the HTML and output JSON
# Pipe curl output directly to python to avoid shell variable issues
curl -s \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "search=${SEARCH_TERM}" \
  "$URL" | python3 "$PYTHON_SCRIPT_FILE"