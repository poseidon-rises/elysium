{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;
  networking = {
    inherit (config.chaos) hostName;
  };
}
