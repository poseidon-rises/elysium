{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
in
{
  options.elysium.shells.programs.fastfetch.enable = lib.mkEnableOption "Fastfetch" // {
    default = cfg'.enableFun;
  };

  config = {
    xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch.jsonc;

    programs.fastfetch.enable = true;
  };
}
