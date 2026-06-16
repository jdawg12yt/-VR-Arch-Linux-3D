#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_DIR="$ROOT_DIR/aosp"

cat <<EOF
Quest 2 AOSP scaffold is ready.

Root: $ROOT_DIR
AOSP scaffold: $AOSP_DIR

Next steps:
1. Sync a full AOSP checkout outside this repository.
2. Replace the placeholders in device/meta/quest2/ with the real device tree.
3. Add vendor blobs under vendor/meta/quest2/.
4. Point your build system at the real kernel source tree.
EOF
