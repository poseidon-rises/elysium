{
  config,
	inputs,
  lib,
  ...
}:

let
  cfg' = config.elysium.browsers;
  cfg = cfg'.browsers.zen;
in
{
	imports = [
		inputs.zen-browser.homeModules.default
	];
  options.elysium.browsers.browsers.zen.enable = lib.mkEnableOption "Zen Browser";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.zen-browser.enable = true;
  };
}
