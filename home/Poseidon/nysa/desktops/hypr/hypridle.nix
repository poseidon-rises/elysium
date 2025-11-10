{
  config,
  lib,
  ...
}:

let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.desktops.hypr.idle;
in
{
  options.nysa.Poseidon.desktops.hypr.idle.enable = lib.mkEnableOption "Hypridle" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 330;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
