{
  config,
  lib,
  pkgs,
  ...
}:

let
  desktopCfg = config.elysium.desktops;
  cfg' = config.elysium.development.tools;
  cfg = cfg'.dbeaver;
in
{
  options.elysium.development.tools.dbeaver.enable = lib.mkEnableOption "Just command runner" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg.enable && desktopCfg.enable) {
    home.packages = [ pkgs.dbeaver-bin ];
  };
}
