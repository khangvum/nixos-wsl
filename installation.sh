#!/bin/bash

# Define the working directory path
DOTFILES_PATH="/etc/nixos/.dotfiles"

# Apply system-wide configuration
sudo nixos-rebuild switch --flake $DOTFILES_PATH

# Apply user-specific configuration
home-manager switch --flake $DOTFILES_PATH