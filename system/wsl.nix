{ config, lib, pkgs, hostname, username, ... }:

{
  wsl = {
    enable = true;
    defaultUser = username;
    docker-desktop.enable = true;

    wslConf = {
      # boot
      boot.systemd = true;

      # automount
      automount = {
        enabled = true;
        root = "/mnt";
      };

      # interop
      interop = {
        appendWindowsPath = true;
        enabled = true;
      };

      # network
      network = {
        generateHosts = true;
        generateResolvConf = true;
        hostname = hostname;
      };

      # user
      user.default = username;
    };
  };
}