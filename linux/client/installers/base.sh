#!/bin/bash
set -Eeuo pipefail

sudo pacman -Syu --noconfirm \
  base-devel \
  git \
  vim \
  zip \
  curl \
  wget

# Install yay (AUR helper)
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

# Docker
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
