#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

message="${1:-chore: refresh generated vendor files}"

cd "$REPO_ROOT"
git add .
git commit -m "$message" || true
if git remote get-url origin >/dev/null 2>&1; then
  git push || true
fi
