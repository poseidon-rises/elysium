{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.browsers;
  cfg = cfg'.browsers.zen;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.elysium.browsers.browsers.zen = {
    enable = lib.mkEnableOption "Zen Browser";
    package =
      lib.mkPackageOption inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system} "beta"
        { pkgsText = "zen-flake-pkgs"; };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.zen-browser = {
      enable = true;
      inherit (cfg) package;
    };
  };
}
