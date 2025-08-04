{ inputs, lib, ... }:

{
  imports = lib.elysium.scanPaths ./. ++ [
    inputs.disko.nixosModules.disko
  ];
}
