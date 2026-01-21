#!/bin/bash
set -Eeuo pipefail

echo "Installing base packages..."
sudo pacman -Syu --noconfirm \
  base-devel \
  git \
  vim \
  zip \
  curl \
  wget

# Install yay (AUR helper)
echo "Installing yay (AUR helper)..."
if ! command -v yay &>/dev/null; then
  [ -d /tmp/yay ] && rm -rf /tmp/yay
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

# Docker
echo "Installing Docker..."
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
