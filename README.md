# -VR-Arch-Linux-3D

Bootable Arch Linux VR OS scaffold.

This repository now builds an Arch-based ISO that boots into Xorg, starts a local web server, and opens the VR shell directly into the 3D scene in a browser chosen at boot time.

It now also includes a conservative custom-kernel scaffold for VR use. It is designed to keep the stock Arch kernel path available as a fallback.

## Build

Install `archiso` on an Arch Linux build host, then run:

```bash
./build-iso.sh
```

The ISO is written to `out/`.

## Boot Flow

1. System boots into `vr-shell.service`.
2. `xinit` starts a lightweight desktop session.
3. A local server exposes the VR shell from `/usr/share/vr-os`.
4. A compatible browser opens the shell in kiosk mode and lands in the 3D scene.

## Notes

- `index.html`, `manifest.json`, and `sw.js` are copied into the ISO at build time.
- The WebXR path uses standard `immersive-vr` session negotiation and falls back when optional features are unavailable.
- The app defaults to scene-first mode and shows only a minimal XR entry control.
- Set `VR_BROWSER_CMD` if you want to force a specific browser on a given VR runtime.
- The kernel scaffold is conservative by design and does not guarantee against a bad flash.
- Keep a known-good kernel installed and test the new kernel from removable media before replacing anything on-device.

## Kernel Scaffold

The custom-kernel files live in `kernel/`.

To prepare a kernel tree, point the build script at a local Linux source tree and let it merge the VR-safe config fragment:

```bash
KERNEL_SRC=/path/to/linux ./kernel/build-vr-safe-kernel.sh
```

## Quest Android Port

If you want a true Quest-side device port, see [quest-android/README.md](quest-android/README.md).

The repository now includes a placeholder Quest 2 AOSP scaffold and build helpers:

- `quest-android/scripts/build-quest2-image.sh /path/to/aosp [output-dir]`
- `quest-android/scripts/flash-quest2.sh /path/to/output`

This still requires a full AOSP checkout, Quest 2 device tree, vendor blobs, and verified boot signing.
