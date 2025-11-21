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
			{
				connector = "HDMI-A-1";
				width = 1920;
				height = 1080;
				refreshRate = 60;
				x = 1366;
				scale = 1.5;
			}
    ];
  };

  elysium.networking.bluetooth.enable = true;

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
