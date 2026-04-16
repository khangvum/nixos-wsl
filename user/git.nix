{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.email = "manhkhang0305@gmail.com";
      user.name = "khangvum";
      init.defaultBranch = "master";
    };
  };
}