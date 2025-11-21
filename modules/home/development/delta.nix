{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.delta;
  gitCfg = config.elysium.development.git;
in
{
  options.elysium.shells.programs.delta.enable = lib.mkEnableOption "Delta" // {
    default = cfg'.enableUseful || gitCfg.enable;
  };

  config = lib.mkIf cfg.enable {
    programs.delta = {
			enable = true;
			enableGitIntegration = true;
			enableJujutsuIntegration = true;
		};
  };
}
