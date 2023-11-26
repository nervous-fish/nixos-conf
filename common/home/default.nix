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

  sops = {
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/nervousfish"];
    defaultSopsFile = ./secrets.yaml;
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
