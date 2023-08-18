{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  boot.kernelParams = [
    "quiet"
    "iommu=pt"
    "vfio-pci.ids=10de:1b06,10de:10ef,1102:0012,10ec:8125,1022:43f6"
    "pcie_acs_override=downstream"
  ];
#  systemd.watchdog.rebootTime = "0";
  
  nixpkgs.config.allowUnfree = true;

  console.keyMap = "us";

  virtualisation.libvirtd = {
    enable = true;
    hooks = {
      qemu = {
        hugePages = "${pkgs.writeShellScript "HPHook.sh" ''
          #!/bin/bash
          VM=$1
          STAGE=$2
          STEP=$3

          echo "$VM $STAGE $STEP" > /tmp/hook-test

          HUGEPAGES="8192"

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

          function alloc () {
            echo "Allocating hugepages..."
            echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
            ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)

            TRIES=0
            while (( $ALLOC_PAGES != $HUGEPAGES && $TRIES < 1000 ))
            do
                echo 1 > /proc/sys/vm/compact_memory            ## defrag ram
                echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
                ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)
                echo "Succesfully allocated $ALLOC_PAGES / $HUGEPAGES"
                let TRIES+=1
            done

            if [ "$ALLOC_PAGES" -ne "$HUGEPAGES" ]
            then
                echo "Not able to allocate all hugepages. Reverting..."
                echo 0 > /proc/sys/vm/nr_hugepages
                exit 1
            fi
          }

          function dealloc () {
            echo 0 > /proc/sys/vm/nr_hugepages
          }
        ''}";
      };
    };
  };
}
