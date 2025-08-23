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

  firefoxExtensions = _final: prev: {
    firefoxExtensions = prev.nur.repos.rycee.firefox-addons;
  };
in
{
  default =
    final: prev: (additions final prev) // (master final prev) // (firefoxExtensions final prev);
}
