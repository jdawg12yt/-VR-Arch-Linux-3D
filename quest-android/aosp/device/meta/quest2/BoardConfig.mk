# Quest 2 board configuration placeholder.
#
# This file is intentionally incomplete. A real build needs the exact
# kernel, partition, display, audio, camera, and AVB settings for the device.

TARGET_BOARD_PLATFORM := quest2
TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
BOARD_VENDOR := meta

# Recovery and boot safety defaults.
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_USES_UEFI := false
