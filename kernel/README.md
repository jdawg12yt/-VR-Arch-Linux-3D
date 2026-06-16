# VR Safe Kernel

This directory contains a conservative kernel scaffold for VR use.

Design goals:

- Keep stock kernel support available as a fallback.
- Avoid risky experimental options.
- Preserve broad hardware support for USB, audio, storage, EFI, and common filesystems.

Safety notes:

- This does not guarantee a device will boot after flashing.
- Test on removable media first.
- Keep a fallback boot entry or recovery image.
- Do not remove the stock kernel until the new one has been verified.

Usage:

```bash
KERNEL_SRC=/path/to/linux ./build-vr-safe-kernel.sh
```