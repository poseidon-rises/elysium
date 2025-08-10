{
  config,
  lib,
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

  config.programs = lib.mkIf (cfg'.enable && cfg.enable) {
    nix-search-tv.enable = true;
    television.channels.nix-search-tv.metadata.name = lib.mkForce "nix";
  };
}
