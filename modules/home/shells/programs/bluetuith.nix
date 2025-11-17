{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.bluetuith;
in
{
  options.elysium.shells.programs.bluetuith.enable = lib.mkEnableOption "bluetuith" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.bluetuith.enable = true;
  };
}
