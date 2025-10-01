{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.internet;
  cfg = cfg'.spotify;
in
{
  options.elysium.programs.internet.spotify.enable = lib.mkEnableOption "Spotify desktop player" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [
      pkgs.nur.repos.nltch.spotify-adblock
    ];
  };
}
