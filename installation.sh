#!/bin/bash

# Apply system-wide configuration
sudo nixos-rebuild switch --flake ~/.dotfiles

# Apply user-specific configuration
home-manager switch --flake ~/.dotfiles