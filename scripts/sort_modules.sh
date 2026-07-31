#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

if [ -f "$OUTPUT_DIR/Android.bp" ]; then
  awk 'NF' "$OUTPUT_DIR/Android.bp" | sort -u > "$OUTPUT_DIR/.android.bp.sorted"
fi
