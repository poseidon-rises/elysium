{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.languages;
  cfg = cfg'.rust;
in
{
  options.elysium.development.languages.rust = {
    enable = lib.mkEnableOption "Rust dev tooling" // {
      default = cfg'.enable;
    };

    toolchain = lib.mkOption {
      default = pkgs.fenix.complete;
      description = "The fenix toolchain to use";
      type =
        with lib.types;
        attrsOf (oneOf [
          package
          (functionTo package)
        ]);
      example = lib.mkLiteral "pkgs.fenix.complete";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.toolchain.toolchain
    ];
  };
}
