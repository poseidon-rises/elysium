{
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.networking.mdns;
in
{
  options.elysium.networking.mdns.enable = lib.mkEnableOption "Avahi mDNS" // {
    default = lib.elem "Graphical" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.avahi.enable = cfg.enable;
  };
}
