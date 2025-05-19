{ config, pkgs, dotfiles_path, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      # - ~/.dotfiles
      ".dotfiles"="cd ${dotfiles_path}";

      # - cd
      ".." = "cd ..";
      "..." = "cd ../../../";
      "...." = "cd ../../../../";
      "....." = "cd ../../../../";
      ".4" = "cd ../../../../";
      ".5" = "cd ../../../../..";

      # - clear
      "c" = "clear";
      "cls" = "clear";

      # - sudo
      "su" = "sudo -i";
      "root" = "sudo -i";

      # - reboot/poweroff/halt/shutdown
      "reboot" = "sudo reboot";
      "poweroff" = "sudo poweroff";
      "halt" = "sudo halt";
      "shutdown" ="sudo shutdown";

      # - ssh
      "ssha" = "eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa";
    };
    initExtra = ''
      # Change the default directory to user's home directory
      cd ~
    '';
  };
}