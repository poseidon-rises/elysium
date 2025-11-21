{ config, lib, ... }:

let
  cfg' = config.elysium.development;
in
{
  imports = lib.elysium.scanPaths ./.;
}
