#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMG_DIR="${1:-$ROOT_DIR/out/quest2-flashable}"

if [[ ! -d "$IMG_DIR" ]]; then
  echo "Image directory not found: $IMG_DIR" >&2
  echo "Run $ROOT_DIR/scripts/build-quest2-image.sh /path/to/aosp [output-dir] first." >&2
  exit 1
fi

if ! command -v fastboot >/dev/null; then
  echo "fastboot is required but was not found in PATH." >&2
  exit 1
fi

cat <<EOF
WARNING: This will flash images to a Quest 2 device. The device bootloader must be unlocked.
Only continue if you have a known-good recovery and understand the risks.
EOF

read -rp "Type YES to continue: " confirm
if [[ "$confirm" != "YES" ]]; then
  echo "Aborted."
  exit 1
fi

fastboot devices

echo "Flashing available images from $IMG_DIR"

for part in boot vendor_boot dtbo system vendor product odm vbmeta vbmeta_system; do
  img="$IMG_DIR/${part}.img"
  if [[ -f "$img" ]]; then
    echo "Flashing $part from $img"
    if [[ "$part" == "vbmeta" || "$part" == "vbmeta_system" ]]; then
      fastboot --disable-verity --disable-verification flash "$part" "$img"
    else
      fastboot flash "$part" "$img"
    fi
  fi
done

if [[ -f "$IMG_DIR/boot.img" ]]; then
  echo "Flashing boot image complete."
fi

echo "Rebooting device..."
fastboot reboot
