{ pkgs, ... }:
{
  services.avizo = {
    enable = true;
    settings = {
      default = {
        time = 2.0;
        block-spacing = 4;
        block-count = 10;
        progress = 1;
        background = "rgba(40, 42, 54, 0.9)";
        bar-fg-color = "rgba(255, 121, 198, 1)";
        bar-bg-color = "rgba(98, 114, 164, 1)";
      };
    };
  };
}
