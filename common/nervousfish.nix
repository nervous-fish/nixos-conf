{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.nervousfish = {
    isNormalUser = true;
    description = "nervous-fish";
    extraGroups = [ "networkmanager" "wheel" "greeter" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
}
