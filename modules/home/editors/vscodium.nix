{
  config,
  lib,
	pkgs,
  ...
}:

let
  cfg = config.elysium.editors.editors.vscodium;
in
{
  options.elysium.editors.editors.vscodium.enable = lib.mkEnableOption "VSCodium" // {
    default = true;
  };
  config = lib.mkIf cfg.enable {
    programs.vscode = {
			enable = true;
			package = pkgs.vscodium;
		};
  };
}
