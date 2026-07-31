#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/.packages.txt" <<EOF
# Auto-generated package inventory
EOF

find "$BLOB_DIR" -type f 2>/dev/null | sed "s#^$BLOB_DIR/##" | sort -u | while IFS= read -r rel; do
  case "$rel" in
    *.apk|*.jar|*.so|*.bin|*.sh|*.rc|*.xml|*.json|*.conf|*.ko)
      echo "$rel" >> "$OUTPUT_DIR/.packages.txt"
      ;;
  esac
done
