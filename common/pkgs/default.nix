{ pkgs, ... }:
{
  environment.systemPackages = let themes = pkgs.callPackage ./sddm-themes.nix { }; in [
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtsvg
    pkgs.libsForQt5.qt5.qtquickcontrols2
    themes.nosddm
  ];
}
