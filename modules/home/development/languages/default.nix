{ hostSpec, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.languages.enable = lib.mkEnableOption "Language tools" // {
    default = hostSpec.isWork;
  };
}
