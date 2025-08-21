{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.ripgrep;
in
{
  options.elysium.shells.programs.ripgrep.enable = lib.mkEnableOption "ripgrep" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.ripgrep.enable = true;
  };
}
