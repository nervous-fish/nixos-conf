{ config, lib, pkgs, pkgs-kernel, ... }:

{
  imports = [
    ../../common/configuration.nix
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

    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];    
    initrd.preDeviceCommands = ''
      DEVS="0000:11:00.0"

      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';

    kernelPackages = pkgs-kernel.linuxPackagesFor pkgs-kernel.linux_6_12;
    kernelModules = [ "kvm-amd" ];
    kernelParams = [
      "quiet"
      "iommu=pt"
      "vfio-pci.ids=10de:1b06,10de:10ef,1022:43f6,1022:15b6,168c:0030"
      "pcie_acs_override=downstream"
    ];
    kernelPatches = [
      {
        name = "add-acs-overrides";
        patch = pkgs-kernel.fetchurl {
          name = "add-acs-overrides.patch";
          url =
            "https://aur.archlinux.org/cgit/aur.git/plain/0001-add-acs-overrides.patch?h=linux-vfio&id=1a1a7ab832756f4fc4e93f569d541127e90bcdd3";
          sha256 = "bdd2a5a56e01e91723907afb40d28bed77b7d5107aba92c85adb3ce6967e713a";
        };
      }
    ];
  };

  fileSystems = {
    "/" = { 
      device = "/dev/disk/by-uuid/907440f7-0aa2-4e34-af99-056efbe3cc96";
      fsType = "ext4";
    };
    "/boot" = { 
      device = "/dev/disk/by-uuid/781D-4308";
      fsType = "vfat";
    };
    "/run/media/nervousfish/nvme1m1p1" = {
      device = "/dev/disk/by-label/nvme1n1p1";
    };
    "/run/media/nervousfish/nvme2m1p1" = {
      device = "/dev/disk/by-label/nvme2n1p1";
    };
  };
  
  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  systemd.watchdog.rebootTime = "15s";

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 nervousfish qemu-libvirtd -"
  ];

  virtualisation.libvirtd = {
    enable = true;
    hooks = {
      qemu = {
        hugePages = "${pkgs.writeShellScript "HPHook.sh" ''
          VM=$1
          STAGE=$2
          STEP=$3

          HUGEPAGES="10240" # allocated_ram / huge_pages_size

          function alloc () {
            echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
            ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)

            TRIES=0
            while (( $ALLOC_PAGES != $HUGEPAGES && $TRIES < 1000 ))
            do
                echo 1 > /proc/sys/vm/compact_memory            ## defrag ram
                echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
                ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)
                let TRIES+=1
            done

            if [ "$ALLOC_PAGES" != "$HUGEPAGES" ]
            then
                dealloc
                exit 1
            fi
          }

          function dealloc () {
            echo 0 > /proc/sys/vm/nr_hugepages
          }

          if [ $VM = "win10" ]
          then
            if [ $STAGE = "prepare" ] && [ $STEP = "begin" ]
            then
              alloc
            elif [ $STAGE = "release" ] && [ $STEP = "end" ]
            then
              dealloc
            fi
          else
            exit 0
          fi
        ''}";
      };
    };
  };
}
