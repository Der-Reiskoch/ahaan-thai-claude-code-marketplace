#!/bin/bash
# thai-cook-book-details.sh - Retrieve information about a Thai cookbook from the library API
#
# Usage: thai-cook-book-details.sh <book-key>
# Example: thai-cook-book-details.sh thailand_das_kochbuch

set -e

API_URL="https://www.ahaan-thai.de/api/thai-cook-book-library.json"

# Check for required argument
if [ -z "$1" ]; then
    echo "Usage: $0 <book-key>" >&2
    echo "" >&2
    echo "Available books:" >&2
    curl -s "$API_URL" | jq -r 'keys[]' | sort >&2
    exit 1
fi

BOOK_KEY="$1"

# Fetch the API data
API_DATA=$(curl -s "$API_URL")

# Check if the book exists
if ! echo "$API_DATA" | jq -e --arg key "$BOOK_KEY" '.[$key]' > /dev/null 2>&1; then
    echo "Error: Book '$BOOK_KEY' not found." >&2
    echo "Available books:" >&2
    echo "$API_DATA" | jq -r 'keys[]' | sort >&2
    exit 1
fi

# Output JSON
echo "$API_DATA" | jq --arg key "$BOOK_KEY" '.[$key] + {book_key: $key}'
