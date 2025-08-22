{
  # Nix
  programs = {
    # Formatters
    nixfmt.enable = true;

    # Linters
    statix.enable = true;
    deadnix.enable = true;
  };

  # CSS, Markdown, YAML, and JSON
  programs = {
    # Formatters
    deno.enable = true;
  };

  # TOML
  programs = {
    # Formatters
    taplo.enable = true;
    toml-sort.enable = true;
  };

  # Bash/sh
  programs = {
    # Formatters
    shellcheck = {
      enable = true;
      excludes = [ ".envrc" ];
    };

    # Linters
    shfmt.enable = true;
  };

  # Fish
  programs = {
    # Formatters
    fish_indent.enable = true;
  };
}
