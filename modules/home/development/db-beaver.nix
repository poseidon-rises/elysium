{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.dbeaver;
in
{
  options.elysium.development.dbeaver.enable = lib.mkEnableOption "Just command runner" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.dbeaver-bin ];
  };
}
