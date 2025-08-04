{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.shells.programs.tv;
  cfg = cfg'.channels.nix;
in
{
  options.elysium.shells.programs.tv.channels.nix.enable =
    lib.mkEnableOption "Enable the tv nix channel"
    // {
      default = cfg'.enable;
    };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.television.channels.nix = {
      metadata.name = "nix";
      source.command = "${lib.getExe pkgs.nix-search-tv} print";
      preview.command = "${lib.getExe pkgs.nix-search-tv} preview {}";
    };
  };
}
