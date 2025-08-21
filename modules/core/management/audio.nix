{ config, lib, ... }:

let
  cfg = config.elysium.management.audio;
in
{
  options.elysium.management.audio.enable = lib.mkEnableOption "audio" // {
    default = lib.elem "Graphical" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
  };
}
