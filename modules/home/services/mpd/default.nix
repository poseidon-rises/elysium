{
  chaos,
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.services.mpd;
in
{
  imports = lib.elysium.scanPaths ./.;
  options.elysium.services.mpd.enable = lib.mkEnableOption "MPD music" // {
    default = lib.elem "Graphical" chaos;
  };

  config = lib.mkIf cfg.enable {
    services.mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
        	type      "pipewire"
        	name      "Pipewire Sound Server"
        } 
        audio_output {
        	type   "fifo"
        	name   "mpd_fifo"
        	path   "/tmp/mpd.fifo"
        	format "44100:16:2"
        }
      '';
    };
    services.mpd-mpris.enable = true;
  };
}
