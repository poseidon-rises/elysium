{ config, lib, ... }:
let
  cfg' = config.nysa.Poseidon;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.input.enable = lib.mkEnableOption "Input Settings" // {
    default = cfg'.enable;
  };
}
