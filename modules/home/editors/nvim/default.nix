{
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.editors.editors.nvim;
in
{
  options.elysium.editors.editors.nvim.enable = lib.mkEnableOption "Neovim and nvf" // {
    default = true;
  };
  config = lib.mkIf cfg.enable {
    programs.neovim.enable = true;

    programs.nvf.enable = true;
  };
}
