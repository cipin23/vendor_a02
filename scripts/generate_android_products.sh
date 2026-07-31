#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

render_template "$REPO_ROOT/templates/android_products.mk.tmpl" "$OUTPUT_DIR/AndroidProducts.mk"
