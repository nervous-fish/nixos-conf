{ pkgs, config, ... }:

{
  imports = [
    ./config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.file."${config.xdg.configHome}/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file."${config.xdg.configHome}/hypr/assets".source = ./assets;
}
