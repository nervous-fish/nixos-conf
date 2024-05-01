{ pkgs, ... }:
{
  home.file.".icons/default".source = "${pkgs.openzone-cursors}/share/icons/OpenZone_Black";
  gtk = {
    enable = true;
    theme.package = pkgs.dracula-theme;
    theme.name = "Dracula";
    iconTheme.package = pkgs.dracula-icon-theme;
    iconTheme.name = "Dracula";
    cursorTheme.package = pkgs.openzone-cursors;
    cursorTheme.name = "OpenZone_Black";
  };
}
