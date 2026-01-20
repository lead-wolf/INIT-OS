#!/bin/bash
set -Eeuo pipefail

# Browsers / Reader
yay -S --noconfirm \
  google-chrome \
  foxitreader

# Office alternative
sudo pacman -S --noconfirm libreoffice-fresh
