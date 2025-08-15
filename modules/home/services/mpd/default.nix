{ chaos, config, lib, ... }:

let
  cfg = config.elysium.services.mpd;
in
{
  options.elysium.services.mpd.enable = lib.mkEnableOption "MPD music" // {
    default = lib.elem "Graphical" chaos;
  };

  config = lib.mkIf cfg.enable {
    services.mpd.enable = true;
    services.mpd-mpris.enable = true;
  };
}
