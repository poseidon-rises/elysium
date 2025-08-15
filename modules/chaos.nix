{ lib, ... }:

{
  options.chaos = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host admin";
      default = "Poseidon";
    };

    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };

    # These help decide defaults for options around the config
    aspects = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
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

    monitors = lib.mkOption {
      type = lib.types.submodule {
        name = lib.mkOption {
          type = lib.types.str;
          example = "HDMI-A-1";
          description = "The name of the monitor device";
        };

        width = lib.mkOption {
          type = lib.types.int;
          example = 1920;
        };

        height = lib.mkOption {
          type = lib.types.int;
          example = 1080;
        };

        x = lib.mkOption {
          type = lib.types.int;
          default = 0;
          example = 1920;
        };

        y = lib.mkOption {
          type = lib.types.int;
          default = 0;
          example = 1080;
        };
      };
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
