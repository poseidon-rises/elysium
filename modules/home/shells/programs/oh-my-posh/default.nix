{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.oh-my-posh;
in
{
  options.elysium.shells.programs.oh-my-posh.enable =
    lib.mkEnableOption "Oh My Posh shell prompt"
    // {
      default = cfg'.enableFun || cfg'.enableUseful;
    };

  config = lib.mkIf cfg.enable {
    programs.oh-my-posh.enable = true;
  };
}
