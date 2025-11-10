{
  config,
  lib,
  ...
}:
let
  cfg' = config.nysa.Poseidon.input;
  cfg = cfg'.compose;
in
{
  options.nysa.Poseidon.input.compose.enable = lib.mkEnableOption "Key Composition" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home = {
      keyboard.options = [ "compose:ralt" ];
      sessionVariables.XCOMPOSEFILE = "${config.xdg.configHome}/XCompose";
    };
    xdg.configFile."XCompose".source = ./.XCompose;
  };
}
