{
  config,
  lib,
  vauxhall,
  ...
}:
let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.shells.programs.oh-my-posh;
in
{
  options.nysa.Poseidon.shells.programs.bluetuith.enable = lib.mkEnableOption "bluetuith" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    programs.bluetuith.settings = {
    };
  };
}
