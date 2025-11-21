{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.programs.utilities;
  cfg = cfg'.tagstudio;
in
{
  options.elysium.programs.utilities.tagstudio.enable = lib.mkEnableOption "TagStudio" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      # inputs.tagstudio.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
