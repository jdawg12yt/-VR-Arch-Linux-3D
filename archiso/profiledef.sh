#!/usr/bin/env bash

pkgbase="vr-arch-linux-3d"
pkgver="1.0"
pkgrel="1"
arch="x86_64"
outdir="out"
workdir="work"
buildmodes=('iso')
bootmodes=('bios.syslinux.x86_64' 'uefi.systemd-boot.x86_64')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xdict-size' '1M')
file_permissions=(
  ["/usr/local/bin/vr-session"]=('0:0' '0755')
  ["/etc/systemd/system/vr-shell.service"]=('0:0' '0644')
)