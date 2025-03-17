{ ... }:

{
  imports = [ ./config.nix ];
  
  programs.alacritty = {
    enable = true;
  };
}
