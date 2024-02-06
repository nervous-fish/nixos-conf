{ config, pkgs, ... }:
{
  home.file."${config.home.homeDirectory}/.local/bin/timer-scripts".source = ./scripts;
}
