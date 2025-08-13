{ config, lib, ... }:

let
	anyUser = lib.elysium.anyUserEnables [ "elysium" "desktops" "enable" ] config;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.desktops.enable = lib.mkEnableOption "desktops" // {
    default = anyUser;
  };

}
