{ pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.nervousfish = {
    isNormalUser = true;
    description = "nervous-fish";
    extraGroups = [ "audio" "networkmanager" "wheel" "greeter" "libvirtd" "docker" "wireshark" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
}
