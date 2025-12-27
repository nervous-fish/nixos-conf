{ ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  systemd.settings.Manager.RebootWatchdogSec = "15s";

  console.useXkbConfig = true;
}
