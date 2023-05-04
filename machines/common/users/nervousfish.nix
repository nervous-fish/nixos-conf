{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.nervousfish = {
    isNormalUser = true;
    description = "Nervous Fish";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
};
