#!/bin/bash
set -Eeuo pipefail

echo "Installing Zsh..."
sudo pacman -S --noconfirm zsh

# Set Zsh as default shell
if [[ "$SHELL" != *zsh ]]; then
  chsh -s "$(which zsh)"
fi

# --------------------
# Oh My Zsh
# --------------------
echo "Installing Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --------------------
# Zsh Plugins
# --------------------
echo "Installing Zsh plugins..."
sudo pacman -S --noconfirm \
  zsh-autosuggestions \
  zsh-syntax-highlighting

ZSHRC="$HOME/.zshrc"

grep -q "zsh-autosuggestions" "$ZSHRC" || \
  sed -i 's/plugins=(/plugins=(zsh-autosuggestions /' "$ZSHRC"

grep -q "zsh-syntax-highlighting" "$ZSHRC" || \
  echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"

# --------------------
# Powerlevel10k
# --------------------
echo "Installing Powerlevel10k..."
if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# Set theme
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"

# --------------------
# Fonts (Nerd Font)
# --------------------
echo "Installing JetBrains Mono Nerd Font..."
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd

fc-cache -fv

# --------------------
# p10k config hook
# --------------------
grep -q "powerlevel10k.zsh-theme" "$ZSHRC" || cat >> "$ZSHRC" <<'EOF'

# Enable Powerlevel10k instant prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

echo "Powerlevel10k installed successfully"
echo "➡ Logout & login, then run: p10k configure"
