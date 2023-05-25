{ config, pkgs, inputs, ... }:

{
  imports = [
    ./alacritty
    ./dunst
    ./git
    ./hyprland
    ./neovim
    ./rofi
    ./starship
    ./swaylock
    ./waybar
    ./wlogout
    ./fish
  ];

  programs.home-manager.enable = true;

  home = {
    username = "nervousfish";
    homeDirectory = "/home/nervousfish";
    stateVersion = "22.11";
  };
}
