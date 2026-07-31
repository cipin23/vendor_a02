#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

if [ -f "$OUTPUT_DIR/a02-vendor.mk" ]; then
  awk '
    /^[[:space:]]*vendor\// { print }
    /^[[:space:]]*PRODUCT_COPY_FILES/ { print }
  ' "$OUTPUT_DIR/a02-vendor.mk" > "$OUTPUT_DIR/.copyfiles.normalized"
fi
