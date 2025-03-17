{ ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      themes = {
        dracula = {
          fg = "#f8f8f4";
          bg = "#282a36";
          black = "#000000";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#6272a4";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#ffffff";
          orange = "#ffb86c";
        };
      };
    };
  };
}
