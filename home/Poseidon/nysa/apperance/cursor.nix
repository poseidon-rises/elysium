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
  options.nysa.Poseidon.apperance.cursor.enable = lib.mkEnableOption "Cursor customization" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      name = "LyraP-cursors";
      package = pkgs.lyra-cursors;
      size = 36;
      gtk.enable = true;
      hyprcursor.enable = true;
      hyprcursor.size = 36;
    };
  };
}
