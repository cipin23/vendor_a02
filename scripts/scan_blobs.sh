#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

manifest_file="$OUTPUT_DIR/.blob-manifest.txt"
mkdir -p "$OUTPUT_DIR"

find "$BLOB_DIR" -type f 2>/dev/null | sed "s#^$BLOB_DIR/##" | sort -u > "$manifest_file"

printf 'Scanned %s entries from %s\n' "$(wc -l < "$manifest_file")" "$BLOB_DIR"
