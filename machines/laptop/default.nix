{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  boot.kernelParams = [ "intel_idle.max_cstate=1" "i915.enable_psr=0" "quiet" "module_blacklist=nouveau" ];
  systemd.watchdog.rebootTime = "0";
  
  nixpkgs.config.allowUnfree = true;
}
