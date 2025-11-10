{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.apperance.qt;
in
{
  options.nysa.Poseidon.apperance.qt.enable = lib.mkEnableOption "Qt" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      candy-icons
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
  };
}
