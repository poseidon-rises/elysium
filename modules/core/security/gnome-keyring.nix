{ config, lib, ... }:

let
  cfg = config.elysium.security.gnome-keyring;
in
{
  options.elysium.security.gnome-keyring.enable = lib.mkEnableOption "Gnome Keyring" // {
    default = lib.elem "Graphical" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
