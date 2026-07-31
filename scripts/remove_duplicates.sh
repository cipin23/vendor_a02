#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

for file in "$OUTPUT_DIR/proprietary-files.txt" "$OUTPUT_DIR/.blob-manifest.txt" "$OUTPUT_DIR/.packages.txt"; do
  if [ -f "$file" ]; then
    sort -u "$file" -o "$file"
  fi
done
