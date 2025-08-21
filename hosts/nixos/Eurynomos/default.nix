{
  lib,
  ...
}:

{
  imports = lib.elysium.scanPaths ./.;
  chaos = {
    hostName = "Eurynomos";

  };

  # Just don't change unless absolutly necessary
  system.stateVersion = "24.11"; # Did you read the comment?
}
