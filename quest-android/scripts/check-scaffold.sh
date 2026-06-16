#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REQUIRED=(
  "$ROOT_DIR/aosp/README.md"
  "$ROOT_DIR/aosp/device/meta/quest2/AndroidProducts.mk"
  "$ROOT_DIR/aosp/device/meta/quest2/BoardConfig.mk"
  "$ROOT_DIR/aosp/device/meta/quest2/device.mk"
  "$ROOT_DIR/aosp/device/meta/quest2/quest2_vr.mk"
  "$ROOT_DIR/aosp/vendor/meta/quest2/README.md"
  "$ROOT_DIR/aosp/build/target/product/quest2_vr.mk"
)

for path in "${REQUIRED[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "Missing scaffold file: $path" >&2
    exit 1
  fi
done

echo "Quest 2 AOSP scaffold check: OK"
