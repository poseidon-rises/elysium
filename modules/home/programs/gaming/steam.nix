{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.programs.office;
in
{
  options.elysium.programs.gaming.steam.enable = lib.mkEnableOption "Okular" // {
    default = cfg'.enable;
  };
}
