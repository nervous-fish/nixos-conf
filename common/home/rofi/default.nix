{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      drun-display-format = "{name}";
      window-format = "{w}{t}";
      font = "FiraCode Nerd Font 10";
      icon-theme = "Tela-circle-dracula-dark";
    };
    theme = ./theme.rasi;
  };
}
