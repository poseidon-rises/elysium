{ config, lib, ... }:

let
	cfg = config.elysium.editors;
in {
  imports = [(
		lib.elysium.mkSelectorModule [ "elysium" "editors" ] {
			name = "default";
			default = "nvim";
			example = "vscodium";
			description = "Default editor for the user";
		})
	] ++ lib.elysium.scanPaths ./.;

	config = {
		home.sessionVariables.EDITOR = cfg.default;
	};
}
