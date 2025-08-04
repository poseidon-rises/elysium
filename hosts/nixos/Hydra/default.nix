{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  hostSpec = {
    hostName = "Hydra";
    isDesktop = true;
  };

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
