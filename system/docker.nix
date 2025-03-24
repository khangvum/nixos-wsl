{ config, lib, pkgs, hostname, username, ... }:

{
    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
      enableOnBoot = true;
    };
}