{
  config,
  lib,

  ...
}:

let
  cfg = config.elysium.management.geolocation;
in
{
  options.elysium.management.geolocation.enable = lib.mkEnableOption "Geolocation" // {
    default = lib.elem "Mobile" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.geoclue2.enable = cfg.enable;
    location.provider = "geoclue2";
  };
}
