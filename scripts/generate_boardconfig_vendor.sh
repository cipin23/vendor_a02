#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

render_template "$REPO_ROOT/templates/boardconfig_vendor.mk.tmpl" "$OUTPUT_DIR/BoardConfigVendor.mk"
