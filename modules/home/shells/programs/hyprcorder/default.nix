{ config, lib, pkgs, ... }:

let 
	cfg' = config.elysium.shells.programs;
	cfg = cfg'.hyprcorder;

	hyprlandCfg = config.elysium.desktops.desktops.hyprland;
in {
	options.elysium.shells.programs.hyprcorder.enable = lib.mkEnableOption "Hyprcorder" // {
		default = cfg'.enableUseful;
	};

	config = lib.mkIf (cfg.enable && hyprlandCfg.enable) {
		home.packages = [ pkgs.hyprcorder ];
	};
}
