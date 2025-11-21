{ config, lib, ... }:

let
  cfg' = config.elysium.development;
  cfg = cfg'.direnv;
in
{
  options.elysium.development.direnv = {
    enable = lib.mkEnableOption "Direnv" // {
      default = cfg'.enable;
    };

    nix-direnv = lib.mkEnableOption "Nix direnv integration" // {
      default = cfg.enable;
    };
  };

  config = lib.mkMerge [
		(lib.mkIf cfg.enable {
			programs.direnv = {
				enable = true;
				silent = true;
			};
		})
		(lib.mkIf cfg.nix-direnv {
			programs.direnv.nix-direnv.enable = true;
		})
	];
}
