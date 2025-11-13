{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    supportedFilesystems = [ "ntfs" ];

    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_6_17;

    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];

    kernelParams = [
      "quiet"
    ];

    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/907440f7-0aa2-4e34-af99-056efbe3cc96";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/781D-4308";
      fsType = "vfat";
    };

  fileSystems."/run/media/nervousfish/floppy1" = {
    device = "/dev/disk/by-uuid/fd5af435-58da-461e-9522-c7943f528758";
  };

  fileSystems."/run/media/nervousfish/floppy2" = {
    device = "/dev/disk/by-uuid/2930271e-7a79-4605-aa75-2d694c10544b";
  };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  # hardware.nvidia.prime = {
  #   offload.enable = true;
  #   offload.enableOffloadCmd = true;
  #   nvidiaBusId = "PCI:1:0:0";
  #   amdgpuBusId = "PCI:22:0:0";
  # };
}
