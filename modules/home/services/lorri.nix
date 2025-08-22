{
  chaos,
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.services.lorri;
in
{
  options.elysium.services.lorri.enable = lib.mkEnableOption "Lorri daemon" // {
    default = lib.elem "Work" chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.lorri.enable = true;
  };
}
