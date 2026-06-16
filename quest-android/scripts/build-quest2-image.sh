#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AOSP_ROOT="${1:-}"
OUT_DIR="${2:-$ROOT_DIR/out/quest2-flashable}"

if [[ -z "$AOSP_ROOT" ]]; then
  cat <<EOF >&2
Usage: $0 /path/to/aosp [output-dir]

This helper builds a Quest 2 flashable image package from a full AOSP checkout.
You must supply a working Quest 2 device tree, vendor blobs, and build checkout.
EOF
  exit 1
fi

if [[ ! -f "$AOSP_ROOT/build/envsetup.sh" ]]; then
  echo "AOSP root does not contain build/envsetup.sh: $AOSP_ROOT" >&2
  exit 1
fi

pushd "$AOSP_ROOT" >/dev/null
source build/envsetup.sh

echo "Using AOSP tree: $AOSP_ROOT"
echo "Configuring Quest 2 product..."
lunch quest2_vr-userdebug

echo "Building Quest 2 OTAPackage..."
make -j"$(nproc)" otapackage

PRODUCT_DIR="$AOSP_ROOT/out/target/product/quest2"
if [[ ! -d "$PRODUCT_DIR" ]]; then
  echo "Expected product output directory not found: $PRODUCT_DIR" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

for file in boot.img vendor_boot.img dtbo.img system.img vendor.img product.img odm.img vbmeta.img vbmeta_system.img; do
  if [[ -f "$PRODUCT_DIR/$file" ]]; then
    cp "$PRODUCT_DIR/$file" "$OUT_DIR/"
  fi
done

find "$PRODUCT_DIR" -maxdepth 1 -type f \( -name "*.zip" -o -name "*.img" \) -print | while read -r f; do
  base="$(basename "$f")"
  case "$base" in
    *target_files*.zip|*ota*.zip)
      cp "$f" "$OUT_DIR/"
      ;;
  esac
done

popd >/dev/null

echo "Flashable Quest 2 artifacts copied to: $OUT_DIR"
echo "Review the output directory before flashing."
echo "Use $ROOT_DIR/scripts/flash-quest2.sh $OUT_DIR to flash the images via fastboot."
