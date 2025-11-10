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
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

  stable = final: _prev: {
    master = import inputs.stable {
      inherit (final.stdenv.hostPlatform) system;
      config.allow = true;
    };
  };

  firefoxExtensions = _final: prev: {
    firefoxExtensions = prev.nur.repos.rycee.firefox-addons;
  };

  nvimPackages = final: _prev: {
    nvf = inputs.nvf.packages.${final.stdenv.hostPlatform.system};
  };
in
{
  default =
    final: prev:
    (additions final prev)
    // (master final prev)
    // (stable final prev)
    // (firefoxExtensions final prev)
    // (nvimPackages final prev);
}
