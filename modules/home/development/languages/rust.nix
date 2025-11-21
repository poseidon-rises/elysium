{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.languages.rust;
in
{
  options.elysium.development.languages.rust = {
    enable = lib.mkEnableOption "Rust dev tooling" // {
      default = cfg'.enable;
    };

    toolchain = lib.mkOption {
      default = pkgs.fenix.complete;
      type =
        with lib.types;
        attrsOf (oneOf [
          package
          (functionTo package)
        ]);
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.toolchain.toolchain
    ];
  };
}
