{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.jj;
in
{
  options.elysium.development.jj = {
    enable = lib.mkEnableOption "Jujutsu VSC" // {
      default = cfg'.enable;
    };

    ui.enable = lib.mkEnableOption "Jujutsu TUI" // {
      default = cfg.enable;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.jujutsu.enable = true;
    })
    (lib.mkIf (cfg.enable && cfg.ui.enable) {
      programs.jjui.enable = true;
    })
	];
}
