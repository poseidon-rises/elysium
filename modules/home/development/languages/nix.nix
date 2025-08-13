{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.languages;
  cfg = cfg'.nix;
in
{
  options.elysium.development.languages.nix.enable = lib.mkEnableOption "Nix Dev" // {
		default = cfg'.enable;
	};

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nixd
      pkgs.manix
      pkgs.statix
      pkgs.deadnix
    ];
  };
}
