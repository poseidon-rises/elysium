{
  config,
  lib,
  pkgs,
  ...
}:

let
  devCfg = config.elysium.development;
  langCfg = devCfg.languages;

  cfg = config.elysium.shells.programs.neovim;
in
{
  options.elysium.shells.programs.neovim.enable = lib.mkEnableOption "Neovim and nvf" // {
    default = true;
  };
  config = lib.mkIf cfg.enable {
    # Enable fzf
    elysium.shells.programs.fzf.enable = lib.mkDefault true;

    programs.neovim = {
      enable = true;
    };
  };
}
