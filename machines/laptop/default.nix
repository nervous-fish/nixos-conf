{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  boot.kernelParams = [ 
    "quiet" 
    "module_blacklist=nouveau" 
  ];
  systemd.watchdog.rebootTime = "0";
  
  nixpkgs.config.allowUnfree = true;
}
