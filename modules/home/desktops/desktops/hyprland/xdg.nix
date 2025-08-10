{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    xdgOpenUsePortal = true;

    config = {
      common = {
        default = [ "kde" ];
      };
    };
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
    MOZ_ENABLE_WAYLAND = 1;
  };
}
