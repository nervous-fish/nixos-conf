{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
    iconTheme.package = pkgs.dracula-icon-theme;
    iconTheme.name = "Dracula";
  };
}
