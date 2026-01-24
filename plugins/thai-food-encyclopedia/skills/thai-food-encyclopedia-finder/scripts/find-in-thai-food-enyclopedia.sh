#!/bin/bash

# This script fetches data from the Thai Food Encyclopedia APIs (German and English)
# and searches for a given term in the 'transcription', 'summary', and 'thaiName' fields.

# Usage: ./find-in-thai-food-encyclopedia.sh <search-term>

set -euo pipefail

# Check if a search term is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <search-term>"
  exit 1
fi

SEARCH_TERM="$1"
URL_DE="https://www.ahaan-thai.de/api/thai-food-encyclopedia.json"
URL_EN="https://en.ahaan-thai.de/api/thai-food-encyclopedia.json"

# Function to fetch and filter data
# It takes a URL as the first argument and a search term as the second.
fetch_and_filter() {
  local url="$1"
  local term="$2"

  # curl -s: silent mode
  # jq --arg term "$term": passes the shell variable to jq
  # .[]: iterates over the input array
  # select(...): filters elements based on a condition
  # test($term; "i"): performs a case-insensitive regex match
  curl -s "$url" | jq --arg term "$term" '
    [
      .[] | select(
        (.transcription | test("^" + $term + "$"; "i")) or
        (.summary | test("^" + $term + "$"; "i")) or
        (.thaiName | test("^" + $term + "$"; "i")) or
        (.alternativeNames[]? | test("^" + $term + "$"; "i"))
      )
    ]
  '
}

# Fetch and filter from both German and English sources
# The results are stored in variables.
RESULTS_DE=$(fetch_and_filter "$URL_DE" "$SEARCH_TERM")
RESULTS_EN=$(fetch_and_filter "$URL_EN" "$SEARCH_TERM")

# Return both German and English results in a structured object.
jq -n --argjson de "$RESULTS_DE" --argjson en "$RESULTS_EN" '
  {
    "de": $de,
    "en": $en
  }
'
