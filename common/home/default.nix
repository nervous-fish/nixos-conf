{ config, pkgs, inputs, ... }:

{
  imports = [
    ./alacritty
    ./avizo
    ./dunst
    ./git
    ./gtk
    ./neovim
    ./rofi
    ./starship
    ./swaylock
    ./waybar
    ./wlogout
    ./fish
    ./zellij
  ];

  programs.home-manager.enable = true;

  home = {
    username = "nervousfish";
    homeDirectory = "/home/nervousfish";
    stateVersion = "22.11";
  };
}
