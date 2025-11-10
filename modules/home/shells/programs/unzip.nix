{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.unzip;
in
{
  options.elysium.shells.programs.unzip.enable = lib.mkEnableOption "Unzip" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.unzip ];
  };
}
