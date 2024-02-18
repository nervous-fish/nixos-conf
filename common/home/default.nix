{ config, pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "nervousfish";
    homeDirectory = "/home/nervousfish";
    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  imports = [
    ./alacritty
    ./git
    ./neovim
    ./starship
    ./fish
    ./zellij
    ./firefox
    ./timers
  ];
}
