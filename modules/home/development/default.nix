{ hostSpec, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

	options.elysium.development.enable = lib.mkEnableOption "Development" // {
    default = hostSpec.isWork;
  };
}
