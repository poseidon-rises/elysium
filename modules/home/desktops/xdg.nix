{ config, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;

      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/dwn";
      music = "${config.home.homeDirectory}/med/msc";
      pictures = "${config.home.homeDirectory}/med/img";
      videos = "${config.home.homeDirectory}/med/vid";
    };
  };
}
