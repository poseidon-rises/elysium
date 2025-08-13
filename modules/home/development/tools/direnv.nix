{ config, lib, ... }:

let
  cfg' = config.elysium.development.tools;
  cfg = cfg'.direnv;
in
{
  options.elysium.development.tools.direnv = {
    enable = lib.mkEnableOption "Direnv" // {
      default = cfg'.enable;
    };

    nix-direnv = lib.mkEnableOption "Nix direnv integration" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;

      nix-direnv.enable = cfg.nix-direnv;

      silent = true;
    };
  };
}
