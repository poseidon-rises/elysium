{ chaos, lib, ... }:

let

in {
  imports = lib.elysium.scanPaths ./.;

	options.elysium.development.enable = lib.mkEnableOption "Development" // {
    default = lib.elem "Work" chaos.aspects;
  };
}
