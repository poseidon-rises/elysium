{ ... }:

{
  # Nix
  programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };

  # Config formats
  programs.yamlfmt.enable = true;
  programs.jsonfmt.enable = true;
}
