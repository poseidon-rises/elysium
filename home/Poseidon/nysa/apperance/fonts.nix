{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.apperance.cursor;
in
{
  options.nysa.Poseidon.apperance.fonts.enable = lib.mkEnableOption "Install fonts" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-extra
      noto-fonts-color-emoji
      twemoji-color-font
    ];
  };
}
