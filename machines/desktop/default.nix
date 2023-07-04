{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  boot.kernelParams = [
    "quiet"
    "iommu=pt"
    "vfio-pci.ids=10de:1b06,10de:10ef"
  ];
  systemd.watchdog.rebootTime = "0";
  
  nixpkgs.config.allowUnfree = true;

  console.keyMap = "us";

  virtualisation.libvirtd = {
    enable = true;
  };
}
