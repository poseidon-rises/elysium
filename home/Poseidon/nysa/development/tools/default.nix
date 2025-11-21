{ config, lib, ... }:

let
	cfg' = config.nysa.Poseidon.development;
in{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.development.tools.enable = lib.mkEnableOption "Development Tools" // {
		default = cfg'.enable;
	};
}
