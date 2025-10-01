{ config, lib, ... }:

let
	cfg = config.elysium.browsers;
	browserDetails = {
		firefox = {
			command = "firefox";
			desktopFile = "firefox.desktop";
		};

		zen = {
			command = "zen-beta";
			desktop = "zen-beta.desktop";
		};
	};
in {
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

		defaultDetails = lib.mkOption {
			default = browserDetails.${cfg.default};
			readOnly = true;
		};
	};
}
