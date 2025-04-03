{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "khangvum";
    userEmail = "manhkhang0305@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}