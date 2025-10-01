{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.apperance.enable = lib.mkEnableOption "Apperence Settings" // {
    default = config.nysa.Poseidon.enable;
  };
}
