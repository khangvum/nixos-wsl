{ config, lib, pkgs, username, dotfiles_path, ... }:

{
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ "${dotfiles_path}/secrets/ssh" ];
  };
}