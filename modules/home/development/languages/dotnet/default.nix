{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.languages;
  cfg = cfg'.dotnet;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.languages.dotnet.enable = lib.mkEnableOption "Dotnet" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.dotnetCorePackages.sdk_9_0 ];
  };
}
