#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE_DIR="$ROOT_DIR/archiso"
APP_DIR="$PROFILE_DIR/airootfs/usr/share/vr-os"

mkdir -p "$APP_DIR"
cp "$ROOT_DIR/index.html" "$APP_DIR/index.html"
cp "$ROOT_DIR/manifest.json" "$APP_DIR/manifest.json"
cp "$ROOT_DIR/sw.js" "$APP_DIR/sw.js"

if ! command -v mkarchiso >/dev/null 2>&1; then
  echo "mkarchiso not found. Install archiso on an Arch build host." >&2
  exit 1
fi

rm -rf "$ROOT_DIR/work" "$ROOT_DIR/out"
mkarchiso -v -w "$ROOT_DIR/work" -o "$ROOT_DIR/out" "$PROFILE_DIR"