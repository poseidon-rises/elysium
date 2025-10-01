{
  lib,
  ...
}:

{
  options.elysium.programs.gaming.enable = lib.mkEnableOption "Gaming Apps";

  imports = lib.elysium.scanPaths ./.;
}
