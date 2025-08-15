{ config, lib, ... }:

let
  cfg' = config.elysium.development;
in {
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.languages.enable = lib.mkEnableOption "Language tools" // {
    default = cfg'.enable;
  };
}
