{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.browsers.enable = lib.mkEnableOption "browser settings" // {
    default = config.nysa.Poseidon.enable;
  };
}
