#!/bin/bash

# 1. AKTUALIZACE SYSTEMU A REPOZITARU
sudo zypper ref
sudo zypper dup -y

# 2. ZAKLADNI NASTROJE A ZAVISLOSTI
# Balicky pro Neovim, Emacs, Xmonad a tvuj workflow
sudo zypper in -y \
    neovim emacs kitty xmonad xmonad-contrib xmobar \
    git gh git-delta ripgrep fd-find xclip htop make cmake gcc-c++ \
    nodejs20 npm-default python311 python311-pip python311-pynvim \
    rustup cargo go haskell-stack ghc \
    picom nitrogen polybar rofi nautilus gnome-characters \
    google-noto-coloremoji-fonts adobe-sourcecodepro-fonts

# 3. INSTALACE FONTU (CaskaydiaCove Nerd Font)
# Pokud uz mas fonts/ v repozitari, skopirujeme je, jinak stahneme
if [ -d "./fonts" ]; then
    echo "Instaluji fonty z lokalni slozky..."
    mkdir -p ~/.local/share/fonts
    cp -r ./fonts/* ~/.local/share/fonts/
else
    echo "Stahuji CaskaydiaCove Nerd Font..."
    mkdir -p ~/.local/share/fonts
    curl -fLo "Caskaydia.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
    unzip -o Caskaydia.zip -d ~/.local/share/fonts
    rm Caskaydia.zip
fi
fc-cache -fv

# 4. PRIPRAVA STRUKTURY V HOME
mkdir -p ~/.config
mkdir -p ~/org
mkdir -p ~/markdownNotes/denik

# 5. SYMLINKY (Propojeni dotfiles z teto slozky do systemu)
# Bereme aktualni cestu
DOT_DIR=$(pwd)

# X11 a Xmonad
ln -sf $DOT_DIR/x11/.Xmodmap ~/.Xmodmap
ln -sf $DOT_DIR/.xmonad ~/.xmonad

# .config (Kitty, Neovim, Polybar, Picom, Rofi atd.)
# Skopiuje nebo nalinkuje cely obsah .config
cp -rs $DOT_DIR/.config/* ~/.config/

# Vim (klasicky)
ln -sf $DOT_DIR/.vimrc ~/.vimrc
ln -sf $DOT_DIR/.vim ~/.vim

# Emacs
ln -sf $DOT_DIR/.emacs.d ~/.emacs.d

# 6. DOPLNKY A FINIS
# Instalace pynvim pro pluginy v pythonu
pip3 install pynvim --user

# Nastaveni ZSH jako default shellu (podle kitty.conf)
sudo zypper in -y zsh
chsh -s $(which zsh)

# Kompilace Xmonadu (dulezite pro prvni spusteni)
xmonad --recompile

echo "-------------------------------------------------------"
echo "Instalace dokoncena. Restartuj PC nebo se znovu prihlas."
echo "Nezapomen v Nitrogenu nastavit tapetu (slozka images/)."
echo "-------------------------------------------------------"
