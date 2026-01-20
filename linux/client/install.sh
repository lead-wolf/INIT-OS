#!/bin/bash
set -Eeuo pipefail

# Must NOT run as root
if [[ $EUID -eq 0 ]]; then
  echo "❌ Do not run as root"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

run() {
  echo -e "\n➡ $1"
  bash "$2"
}

echo "🚀 Starting CachyOS setup..."

if $INSTALL_BASE;     then run "Base packages"    "$SCRIPT_DIR/installers/base.sh"; fi
if $INSTALL_DEVTOOLS; then run "Dev tools"        "$SCRIPT_DIR/installers/devtools.sh"; fi
if $INSTALL_APPS;     then run "Applications"     "$SCRIPT_DIR/installers/apps.sh"; fi
if $INSTALL_SHELL;    then run "Zsh + Font"       "$SCRIPT_DIR/installers/shell.sh"; fi

echo -e "\n🎉 Setup completed"
