#!/bin/bash

# Clone the dotfiles
if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.dotfiles
fi
nix-shell -p git --command "git clone https://github.com/khangvum/nixos-wsl.git $SCRIPT_DIR"

# Patch flake.nix and home.nix with the host's username
sed -i "0,/khangvum/s//$(whoami)/" $SCRIPT_DIR/flake.nix
sed -i "0,/khangvum/s//$(whoami)/" $SCRIPT_DIR/home.nix
sed -i "s/manhkhang0305@gmail.com//" $SCRIPT_DIR/home.nix
# - Replaces all occurrences of ~/.dotfiles with the actual SCRIPT_DIR path
sed -i "s+~/.dotfiles+$SCRIPT_DIR+g" $SCRIPT_DIR/flake.nix

# Open flake.nix for manual modification before installation
if [ -z "$EDITOR" ]; then
    EDITOR=nano;
fi
$EDITOR $SCRIPT_DIR/flake.nix;

# Apply system-wide configuration
sudo nixos-rebuild switch --flake $SCRIPT_DIR;

# Apply user-specific configuration
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $SCRIPT_DIR;