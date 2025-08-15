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
  };

  elysium.networking.bluetooth.enable = true;

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
