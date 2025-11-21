{ checks, pkgs, ... }:
pkgs.mkShell {
  inherit (checks.pre-commit-check) shellHook;
  nativeBuildInputs = [
    pkgs.nh
    pkgs.just
  ];
  buildInputs = checks.pre-commit-check.enabledPackages;
}
