{ config, lib, ... }:

let
  anyUserSteam = lib.elysium.anyUserEnables [
    "elysium"
    "programs"
    "gaming"
    "steam"
    "enable"
  ] config;
in
{
  config = lib.mkIf anyUserSteam {
    programs.steam.enable = true;
  };
}
