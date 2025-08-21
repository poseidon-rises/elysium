{ config, lib, ... }:

let
	anyUserFish = lib.elysium.anyUserEnables [ "elysium" "shells" "shells" "fish" "enable" ] config;
	anyUserZsh = lib.elysium.anyUserEnables [ "elysium" "shells" "shells" "zsh" "enable" ] config;
  cfg = config.elysium.shells;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "shells" ] {
      name = "default";
      default = "fish";
      example = "zsh";
      description = "Default shell to use.";
    })
  ];

  options.elysium.shells.shells = {
    zsh.enable = lib.mkEnableOption "Zsh" // {
      default = anyUserZsh;
    };

    fish.enable = lib.mkEnableOption "Fish" // {
      default = anyUserFish;
    };
  };

  config = {
    environment.shellAliases = lib.mkForce { };

    programs = {
      zsh.enable = lib.mkIf cfg.shells.zsh.enable true;
      fish.enable = lib.mkIf cfg.shells.fish.enable true;
    };
		documentation.man.generateCaches = false;

    users.defaultUserShell =
      let
        sCfg = cfg.shells.${cfg.default};
      in
      lib.mkIf (sCfg ? package) (lib.getCfgExe sCfg);

  };
}
