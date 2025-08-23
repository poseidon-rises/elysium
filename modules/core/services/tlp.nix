{ config, lib, ... }:
let
  cfg = config.elysium.services.tlp;
in
{
  options.elysium.services.tlp.enable = lib.mkEnableOption "TLP" // {
    default = lib.elem "Laptop" config.chaos.aspects;
  };

  config = lib.mkIf cfg.enable {
    elysium.services.serviceUser.tlp-sleep = { };

    systemd.services.tlp-sleep.serviceConfig.User = "tlp-sleep-service";

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        PLATFORM_PROFILE_ON_AC = "performance";
      };
    };
  };
}
