{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  config = {
    users.mutableUsers = true;
  };
}
