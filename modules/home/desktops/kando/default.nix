{
  config,
  lib,
  inputs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.kando;
in
{
  options.elysium.desktops.kando.enable = lib.mkEnableOption "Kando Pie Menu";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ inputs.master.legacyPackages."x86_64-linux".kando ];

    elysium.desktops.exec-once = [ "kando" ];
  };
}
