{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.desktops.hypr.enable = lib.mkEnableOption "Hypr* Programs";
}
