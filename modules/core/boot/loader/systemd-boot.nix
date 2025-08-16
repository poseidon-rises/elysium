{ config, lib, ... }:

let
  cfg = config.elysium.boot.loader.systemd-boot;
in
{
  options.elysium.boot.loader.systemd-boot.enable = lib.mkEnableOption "systemd-boot" // {
    default = false;
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      grub.enable = false;
    };
  };
}
