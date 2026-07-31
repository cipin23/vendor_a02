#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

errors=0

if [ ! -f "$OUTPUT_DIR/Android.bp" ]; then
  echo "Missing Android.bp" >&2
  errors=$((errors + 1))
fi
if [ ! -f "$OUTPUT_DIR/Android.mk" ]; then
  echo "Missing Android.mk" >&2
  errors=$((errors + 1))
fi
if [ ! -f "$OUTPUT_DIR/AndroidProducts.mk" ]; then
  echo "Missing AndroidProducts.mk" >&2
  errors=$((errors + 1))
fi
if [ ! -f "$OUTPUT_DIR/BoardConfigVendor.mk" ]; then
  echo "Missing BoardConfigVendor.mk" >&2
  errors=$((errors + 1))
fi
if [ ! -f "$OUTPUT_DIR/proprietary-files.txt" ]; then
  echo "Missing proprietary-files.txt" >&2
  errors=$((errors + 1))
fi
if [ ! -f "$OUTPUT_DIR/a02-vendor.mk" ]; then
  echo "Missing a02-vendor.mk" >&2
  errors=$((errors + 1))
fi

if [ -f "$OUTPUT_DIR/a02-vendor.mk" ]; then
  if grep -q 'vendor/samsung/a02/proprietary/' "$OUTPUT_DIR/a02-vendor.mk"; then
    :
  else
    echo "No vendor copyfiles detected" >&2
    errors=$((errors + 1))
  fi
fi

if [ $errors -gt 0 ]; then
  echo "Validation failed with $errors error(s)." >&2
  exit 1
fi

echo "Validation succeeded."
