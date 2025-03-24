{ config, lib, pkgs, ... }:

{
    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
      enableOnBoot = true;
    };
}