{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  chaos = {
    hostName = "Hydra";
    aspects = [
      "Graphical"
      "Laptop"
      "Work"
      "Mobile"
    ];

    monitors = [
      {
        connector = "eDP-1";
        width = 1366;
        height = 768;
        refreshRate = 60;
      }
    ];
  };

  elysium.networking.bluetooth.enable = true;

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
