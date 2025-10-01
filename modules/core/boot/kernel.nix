{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.elysium.boot;
in
{

  options.elysium.boot = {
    kernel = lib.mkOption {
      type = lib.types.raw;
      default =
        if (lib.elem "Graphical" config.chaos.aspects) then
          pkgs.linuxPackages_zen
        else
          pkgs.linuxPackages.kernels.default;
    };
  };

  config = {
    boot.kernelPackages = cfg.kernel;
    services.logrotate.checkConfig = false;
  };
}
