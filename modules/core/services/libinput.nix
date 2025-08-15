{
  config,
  lib,

  ...
}:

let
  cfg = config.elysium.services.libinput;
in
{
  options.elysium.services.libinput.enable = lib.mkEnableOption "libinput" // {
    default = lib.elem "Laptop" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.libinput.enable = true;
  };
}
