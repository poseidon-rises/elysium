{
  lib,
  ...
}:

{
  imports = lib.elysium.scanPaths ./.;
  chaos = {
    hostName = "Eurynomos";
    aspects = [
      "Graphical"
      "Mobile"
    ];
  };

  # Just don't change unless absolutly necessary
  system.stateVersion = "25.11"; # Did you read the comment?

}
