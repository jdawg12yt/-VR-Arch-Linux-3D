# Quest 2 AOSP Scaffold

This directory is a safe placeholder layout for a Quest 2 Android device-port.

It is not a working device tree and it does not contain proprietary blobs or signed boot images.

## Layout

- `device/meta/quest2/` - device tree placeholder
- `vendor/meta/quest2/` - vendor blob landing area
- `kernel/` - kernel build notes and config fragments
- `build/target/product/` - product definitions
- `scripts/` - validation and bootstrap helpers

## What still needs to exist for a real port

- A complete Quest 2 device tree
- Vendor blobs for the exact hardware revision
- A matching kernel source tree
- AVB and boot image signing setup
- A working AOSP build checkout

## Safe workflow

1. Clone or sync a full AOSP tree outside this repository.
2. Drop the real device tree into `device/meta/quest2/`.
3. Add vendor blobs into `vendor/meta/quest2/`.
4. Point the kernel build at the device-specific kernel source.
5. Build unsigned test images first and verify boot before flashing.
6. Use `scripts/build-quest2-image.sh /path/to/aosp [output-dir]` once the build completes.
7. Review the generated image files carefully before flashing.
