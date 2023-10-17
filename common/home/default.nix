{ config, pkgs, inputs, ... }:

{
  imports = [
    ./alacritty
    ./git
    ./neovim
    ./starship
    ./fish
    ./zellij
    ./firefox
  ];

  programs.home-manager.enable = true;

  home = {
    username = "nervousfish";
    homeDirectory = "/home/nervousfish";
    stateVersion = "22.11";
  };
}
