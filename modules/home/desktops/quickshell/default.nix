{ config, lib, ... }:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.quickshell;
in
{
  options.elysium.desktops.quickshell.enable = lib.mkEnableOption "Quickshell UI";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.quickshell.enable = true;

    elysium.desktops.exec-once.quickshell = {
			command = lib.getExe config.programs.quickshell.package;
		};
  };
}
