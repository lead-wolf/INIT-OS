#!/bin/bash
set -Eeuo pipefail

# Browsers / Reader
echo "Installing chrome"
yay -S --noconfirm google-chrome 

echo "Installing firefox"
yay -S --noconfirm foxitreader

# Office alternative
echo "Installing libreoffice"
sudo pacman -S --noconfirm libreoffice-fresh
