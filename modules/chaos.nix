{ lib, ... }:

let
  inherit (lib) types mkOption;
in
{
  options.chaos = {
    username = mkOption {
      type = types.str;
      description = "The username of the host admin";
      default = "Poseidon";
    };

    hostName = mkOption {
      type = types.str;
      description = "The hostname of the host";
    };

    # These help decide defaults for options around the config
    aspects = mkOption {
      type = types.listOf (
        types.enum [
          "Desktop"
          "Laptop"
          "Server"
          "Graphical"
          "Work"
          "Mobile" # a device that may travel
          "Minimal"
        ]
      );
    };

    monitors = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            connector = mkOption {
              type = types.str;
              example = "HDMI-A-1";
              description = "The name of the monitor device";
            };

            width = mkOption {
              type = types.int;
              example = 1920;
            };

            height = mkOption {
              type = types.int;
              example = 1080;
            };

            refreshRate = mkOption {
              type = types.int;
              default = 60;
              example = 120;
            };

            x = mkOption {
              type = types.int;
              default = 0;
              example = 1920;
            };

            y = mkOption {
              type = types.int;
              default = 0;
              example = 1080;
            };

            scale = mkOption {
              type = types.float;
              default = 1.0;
              description = "Scale of the display.";
            };
          };
        }
      );
    };

    networking = {
      networkmanager = {
        enable = lib.mkEnableOption "NetworkManager" // {
          default = true;
        };

        scanRandMacAddress = lib.mkEnableOption "NetworkManager" // {
          default = true;
        };
      };
    };
  };
}
