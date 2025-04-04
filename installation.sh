#!/bin/bash

# Define the working directory path
DOTFILES_PATH="/etc/nixos/.dotfiles"

# Apply system-wide configuration
sudo nixos-rebuild switch --flake $DOTFILES_PATH

# Check if Home Manager is already installed
if command -v home-manager &> /dev/null; then
    echo "Home Manager is already installed."
else
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi

# Apply user-specific configuration
home-manager switch --flake $DOTFILES_PATH