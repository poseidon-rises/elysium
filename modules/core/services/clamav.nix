{
  config,
  lib,

  ...
}:

let
  cfg = config.elysium.services.clamav;
in
{
  options.elysium.services.clamav = {
    enable = lib.mkEnableOption "ClamAV" // {
      default = lib.elem "Graphical" config.chaos.aspects;
    };
    daemon.enable = lib.mkEnableOption "ClamAV daemon" // {
      default = cfg.enable;
    };

    scanner.enable = lib.mkEnableOption "ClamAV scanner" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    services.clamav = {
      daemon.enable = cfg.daemon.enable;
      scanner.enable = cfg.scanner.enable;
    };
  };
}
