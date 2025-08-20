{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.zoxide;
in
{
  options.elysium.shells.programs.zoxide.enable = lib.mkEnableOption "Zoxide" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
