# Quest Android Port (Flash-able Quest 2 image) Roadmap

Goal: produce a **flashable Quest 2 build** using AOSP (not an ISO). The web UI / WebXR shell remains the app payload, but the OS you flash must be built from a **device-port** (device tree + kernel/vendor + boot/AVB).

A real Quest 2 port is an Android device-port problem:

- Build AOSP for the target device family.
- Use the device-specific kernel tree and vendor modules.
- Keep AVB and boot partitions consistent.
- Flash with fastboot/fastbootd, not raw partition writes.
- Keep a fallback boot path until the new image is proven stable.


## What "doing it right" means

Based on the Android Open Source Project docs, the safe workflow is:

1. Unlock the bootloader only if the device officially supports it.
2. Set up a full AOSP build environment.
3. Obtain the device tree, kernel tree, and proprietary vendor blobs for the exact hardware.
4. Build a kernel and Android images from that device definition.
5. Validate the boot image and AVB chain.
6. Test with a temporary boot path first whenever possible.
7. Flash only after the device boots reliably from the test image.

## Why this repo is not enough by itself

The current repository is a VR shell and Arch ISO scaffold. It does not contain:

- a Quest 2 device tree
- Meta's vendor blobs
- the Android board configuration for the headset
- the signed boot chain needed for a full replacement image

Without those pieces, you can make a headset-facing Android app or launcher, but not a true Quest 2 OS image.

## Safer path in this repo

The repository already includes a conservative kernel scaffold in `kernel/` and a VR shell that can run as a headset app. That is the safe place to keep iterating while preserving a stock recovery path.

## What exists here now

- `aosp/README.md` documents the placeholder AOSP layout.
- `aosp/device/meta/quest2/` contains the Quest 2 device tree scaffold.
- `aosp/vendor/meta/quest2/` is the vendor blob landing area.
- `aosp/build/target/product/quest2_vr.mk` defines the placeholder product.
- `scripts/bootstrap-aosp.sh` and `scripts/check-scaffold.sh` help verify the scaffold.
- `scripts/build-quest2-image.sh` builds a flashable image package from a full AOSP checkout.
- `scripts/flash-quest2.sh` safely flashes built images via fastboot.

## References to follow in the Android docs

- AOSP build setup
- Kernel building
- Flashing with fastboot
- Bootloader lock/unlock
- Verified Boot / AVB
