#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KERNEL_SRC="${KERNEL_SRC:-${1:-}}"
FRAGMENT_FILE="$ROOT_DIR/vr-safe.fragment"
BUILD_DIR="$ROOT_DIR/work"

if [[ -z "$KERNEL_SRC" ]]; then
  echo "Usage: KERNEL_SRC=/path/to/linux ./build-vr-safe-kernel.sh" >&2
  exit 1
fi

if [[ ! -d "$KERNEL_SRC" ]]; then
  echo "Kernel source tree not found: $KERNEL_SRC" >&2
  exit 1
fi

if [[ ! -f "$KERNEL_SRC/Makefile" || ! -d "$KERNEL_SRC/scripts" ]]; then
  echo "KERNEL_SRC must point to a Linux kernel source tree" >&2
  exit 1
fi

for tool in make bc bison flex perl python3 rsync git; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing required build tool: $tool" >&2
    exit 1
  fi
done

mkdir -p "$BUILD_DIR"
cp "$FRAGMENT_FILE" "$BUILD_DIR/vr-safe.fragment"

pushd "$KERNEL_SRC" >/dev/null

if [[ ! -f .config ]]; then
  if [[ -f /proc/config.gz ]]; then
    zcat /proc/config.gz > .config
  else
    make defconfig
  fi
fi

if [[ -x scripts/kconfig/merge_config.sh ]]; then
  scripts/kconfig/merge_config.sh -m .config "$BUILD_DIR/vr-safe.fragment"
else
  echo "merge_config.sh not found; copy vr-safe.fragment into your kernel tree and merge it manually." >&2
  exit 1
fi

make olddefconfig

echo "VR-safe kernel configuration prepared in: $KERNEL_SRC/.config"
echo "Build it with: make -j\"$(nproc)\""
echo "Install modules carefully and keep your fallback kernel installed."

popd >/dev/null