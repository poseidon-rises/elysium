{ config, lib, ... }:

let
  anyUser = lib.elysium.anyUserEnables [ "elysium" "desktops" "desktops" "niri" "enable" ] config;
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.niri;
in
{
  options.elysium.desktops.desktops.niri = {
    enable = lib.mkEnableOption "Niri" // {
      default = anyUser;
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.niri.enable = true;
  };
}
