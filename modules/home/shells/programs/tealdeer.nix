{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.tealdeer;
in
{
  options.elysium.shells.programs.tealdeer.enable = lib.mkEnableOption "tealdeer" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;

      settings = {
        display.use_pager = true;
      };

      enableAutoUpdates = true;
    };
  };
}
