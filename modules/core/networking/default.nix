{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;
  networking = {
    hostName = config.chaos.hostName;
  };
}
