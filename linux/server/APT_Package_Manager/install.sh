#!/bin/bash
set -Eeuo pipefail

trap 'echo "❌ Lỗi tại file $BASH_SOURCE dòng $LINENO"; exit 1' ERR

export DEBIAN_FRONTEND=noninteractive

# Must be root
if [[ $EUID -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

echo "=== BẮT ĐẦU SETUP DEBIAN ==="

for script  in *.sh; do
  if [[ -f "$script" ]]; then
    echo
    echo "▶ Running $script"
    bash "$script"
  fi
done

echo
echo "✅ HOÀN TẤT SETUP"
