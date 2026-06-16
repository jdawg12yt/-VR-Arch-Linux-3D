#!/usr/bin/env bash
set -euo pipefail

systemctl enable vr-shell.service
systemctl enable NetworkManager.service
systemctl set-default multi-user.target
systemctl mask getty@tty1.service