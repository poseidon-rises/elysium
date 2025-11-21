{ config, lib, ... }:

let
	cfg' = config.nysa.Poseidon;
in{
  imports = lib.elysium.scanPaths ./.;

  options.nysa.Poseidon.development.enable = lib.mkEnableOption "Development tooling" // {
		default = cfg'.enable;
	};
}
