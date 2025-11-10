{ config, lib, ... }:

let
  cfg = config.elysium.browsers;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "browsers" ] {
      name = "default";
      default = "zen";
      example = "firefox";
      description = "Default browser to use.";
    })
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.browsers = {
    enable = lib.mkEnableOption "browsers" // {
      default = config.elysium.desktops.enable;
    };
  };

  config = lib.mkIf cfg.enable {

  };
}
