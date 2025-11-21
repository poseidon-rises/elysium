{
  config,
  lib,
  ...
}:

let
  shellCfg = config.elysium.shells;
  cfg' = config.elysium.development.tools.jujutsu;
  cfg = cfg'.jjui;
in
{
  options.elysium.development.tools.jujutsu.jjui.enable = lib.mkEnableOption "Jujutsu TUI" // {
    default = cfg'.enable && shellCfg.programs.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.jjui.enable = true;
  };
}
