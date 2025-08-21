{ config, lib, ... }:

let
  cfg = config.elysium.networking.firewall;
  anyUserKdeConnect = lib.elysium.anyUserEnables [
    "elysium"
    "programs"
    "internet"
    "kdeconnect"
    "enable"
  ] config;
in
{
  options.elysium.networking.firewall = {
    enable = lib.mkEnableOption "firewall" // {
      default = true;
    };
    allowPing = lib.mkEnableOption "allow pings" // {
      default = !lib.elem "Server" config.chaos.aspects;
    };
  };
  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      inherit (cfg) allowPing;
      allowedUDPPortRanges = lib.optional anyUserKdeConnect {
        from = 1714;
        to = 1764;
      };
    };
  };
}
