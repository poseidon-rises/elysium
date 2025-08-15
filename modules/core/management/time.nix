{
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.management.time;
in
{
  options.elysium.management.time = {
    automatic-zone = lib.mkEnableOption "Automatic timezone" // {
      default = lib.elem "Mobile" config.chaos.aspects;
    };
  };

  config = lib.mkMerge [
    { time.timeZone = lib.mkDefault "America/Chicago"; }
    { services.timesyncd.enable = true; }
    (lib.mkIf cfg.automatic-zone {
      elysium.management.geolocation.enable = lib.mkDefault true;

      services.automatic-timezoned.enable = true;
    })
  ];
}
