{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.development.tools;
  cfg = cfg'.jujutsu;
in
{
  imports = lib.elysium.scanPaths ./.;
  options.elysium.development.tools.jujutsu.enable = lib.mkEnableOption "jj VSC system" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    programs.jujutsu.enable = true;
  };
}
