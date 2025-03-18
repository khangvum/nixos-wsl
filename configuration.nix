# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, version, hostname, username, ... }:

{
  # imports = [
  #  
  # ];

  wsl = {
    enable = true;
    defaultUser = username;
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = version; # Did you read the comment?

  # Hostname
  networking.hostName = hostname;

  # Enable Nix flake
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # SSH
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ "/home/${username}/.dotfiles/secrets/ssh" ];
  };
  
  # User settings
  users.mutableUsers = false;
  # - passwd {name}
  # - mkpasswd -m sha-512
  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = "/home/${username}/.dotfiles/secrets/password";
    extraGroups = [
      "wheel"
      "docker" 
    ];
  };

  # Enable password
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  # To install terraform
  nixpkgs.config.allowUnfree = true;

  # Sytem packages
  environment.systemPackages = with pkgs; [
    git
    gcc
    python3
    neovim
    docker
    lazydocker
    powershell
    nettools
    termshark
    ansible
    terraform
    wget  # For vscode-server
  ];

  # docker
  virtualisation.docker.enable = true;

  # vscode-server
  services.vscode-server.enable = true;
}
