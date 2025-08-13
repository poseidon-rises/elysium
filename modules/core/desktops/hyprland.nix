{
  config,
  lib,
  pkgs,
  ...
}:

let
	anyUser = lib.elysium.anyUserEnables [ "elysium" "desktops" "desktops" "hyprland" "enable" ] config;
		
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.hyprland;
in
{
  options.elysium.desktops.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland" // {
      default = anyUser;
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.hyprland = {
      enable = true;
      portalPackage = pkgs.kdePackages.xdg-desktop-portal-kde;
    };
  };
}
