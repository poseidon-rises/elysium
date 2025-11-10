{ checks, pkgs, ... }:
pkgs.mkShell {
  inherit (checks.pre-commit-check) shellHook;
  nativeBuildInputs = [
    pkgs.nh
    pkgs.just
    pkgs.kdePackages.qtdeclarative
    pkgs.quickshell
  ];
  buildInputs = checks.pre-commit-check.enabledPackages;
  QMLLS_BUILD_DIRS = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml/:${pkgs.quickshell}/lib/qt-6/qml/";
}
