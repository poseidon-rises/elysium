{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.enable = lib.mkEnableOption "Poseidon's personal configs";
}
