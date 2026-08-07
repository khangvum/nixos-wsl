{ config, lib, pkgs, ... }:

{
  # Disable resolvconf to prevent collision with environment.etc."resolv.conf" in WSL
  networking.resolvconf.enable = false;
}