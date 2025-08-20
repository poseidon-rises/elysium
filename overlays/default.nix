{ inputs, ... }:

let
  additions =
    final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  master = final: _prev: {
    master = import inputs.master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
in
{
  default = final: prev: (additions final prev) // (master final prev);
}
