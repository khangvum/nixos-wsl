{ config, lib, pkgs, username, ... }:

{
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ "/home/${username}/.dotfiles/secrets/ssh" ];
  };
}