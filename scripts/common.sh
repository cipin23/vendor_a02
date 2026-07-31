#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)"
DEVICE_ROOT=""
VENDOR_FOLDER=""
VENDOR_NAME=""
DEVICE_NAME=""
ANDROID_VERSION=""
ARCHITECTURE=""
BLOB_DIR=""
OUTPUT_DIR=""

escape_sed() {
  printf '%s' "$1" | sed 's/[\\&|]/\\&/g'
}

discover_repo() {
  local root="${1:-$REPO_ROOT}"
  root="$(CDPATH='' cd -- "$root" && pwd)"
  if [ ! -d "$root/.git" ]; then
    echo "Repository root not found: $root" >&2
    exit 1
  fi

  REPO_ROOT="$root"

  local candidate=""
  while IFS= read -r candidate; do
    if [ -d "$candidate/proprietary" ] && [ -f "$candidate/Android.mk" ]; then
      DEVICE_ROOT="$candidate"
      break
    fi
  done < <(find "$REPO_ROOT" -type d -path '*/proprietary' 2>/dev/null | sed 's#/proprietary$##')

  if [ -z "${DEVICE_ROOT:-}" ]; then
    for candidate in "$REPO_ROOT" "$REPO_ROOT/vendor_a02" "$REPO_ROOT/vendor_a02/samsung"; do
      if [ -d "$candidate/proprietary" ] && [ -f "$candidate/Android.mk" ]; then
        DEVICE_ROOT="$candidate"
        break
      fi
    done
  fi

  if [ -z "${DEVICE_ROOT:-}" ]; then
    echo "Unable to detect device root under $REPO_ROOT" >&2
    exit 1
  fi

  DEVICE_ROOT="$(CDPATH='' cd -- "$DEVICE_ROOT" && pwd)"
  local rel_path="${DEVICE_ROOT#"$REPO_ROOT"/}"
  VENDOR_FOLDER="$(printf '%s\n' "$rel_path" | awk -F/ '{print $1}')"
  VENDOR_NAME="$(printf '%s\n' "$rel_path" | awk -F/ '{print $2}')"
  DEVICE_NAME="$(printf '%s\n' "$rel_path" | awk -F/ '{print $3}')"
  BLOB_DIR="$DEVICE_ROOT/proprietary"
  OUTPUT_DIR="$DEVICE_ROOT"

  if [ -f "$BLOB_DIR/build.prop" ]; then
    local version
    version="$(grep -E 'ro\.build\.version\.release=' "$BLOB_DIR/build.prop" | head -n 1 | sed 's/.*=//')" || true
    if [ -n "$version" ]; then
      ANDROID_VERSION="$version"
    fi
  fi
  if [ -z "${ANDROID_VERSION:-}" ]; then
    ANDROID_VERSION="11"
  fi

  if [ -d "$BLOB_DIR/lib/arm64" ] || find "$BLOB_DIR" -type d -name 'arm64*' 2>/dev/null | grep -q .; then
    ARCHITECTURE="arm64"
  elif [ -d "$BLOB_DIR/lib/arm" ] || find "$BLOB_DIR" -type d -name 'arm*' 2>/dev/null | grep -q .; then
    ARCHITECTURE="arm"
  elif [ -d "$BLOB_DIR/lib/x86" ] || find "$BLOB_DIR" -type d -name 'x86*' 2>/dev/null | grep -q .; then
    ARCHITECTURE="x86"
  else
    ARCHITECTURE="arm"
  fi
}

render_template() {
  local template_path="$1"
  local output_path="$2"
  local temp_path
  temp_path="$(mktemp)"
  sed \
    -e "s|__REPO_ROOT__|$(escape_sed "$REPO_ROOT")|g" \
    -e "s|__VENDOR_FOLDER__|$(escape_sed "$VENDOR_FOLDER")|g" \
    -e "s|__VENDOR_NAME__|$(escape_sed "$VENDOR_NAME")|g" \
    -e "s|__DEVICE_NAME__|$(escape_sed "$DEVICE_NAME")|g" \
    -e "s|__ANDROID_VERSION__|$(escape_sed "$ANDROID_VERSION")|g" \
    -e "s|__ARCHITECTURE__|$(escape_sed "$ARCHITECTURE")|g" \
    -e "s|__BLOB_DIR__|$(escape_sed "$BLOB_DIR")|g" \
    -e "s|__OUTPUT_DIR__|$(escape_sed "$OUTPUT_DIR")|g" \
    "$template_path" > "$temp_path"
  mv "$temp_path" "$output_path"
}

print_repo_info() {
  cat <<EOF
REPO_ROOT="$REPO_ROOT"
VENDOR_FOLDER="$VENDOR_FOLDER"
VENDOR_NAME="$VENDOR_NAME"
DEVICE_NAME="$DEVICE_NAME"
ANDROID_VERSION="$ANDROID_VERSION"
ARCHITECTURE="$ARCHITECTURE"
BLOB_DIR="$BLOB_DIR"
OUTPUT_DIR="$OUTPUT_DIR"
EOF
}

discover_repo "$REPO_ROOT"
