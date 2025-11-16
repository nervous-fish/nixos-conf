{ ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  systemd.watchdog.rebootTime = "15s";

  console.useXkbConfig = true;
}
