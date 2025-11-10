{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.art;
  cfg = cfg'.orca-slicer;
in
{
  options.elysium.programs.art.orca-slicer.enable = lib.mkEnableOption "Orca Slicer" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.orca-slicer ];
  };
}
