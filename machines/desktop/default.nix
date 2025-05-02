{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/configuration.nix
  ];

  systemd.watchdog.rebootTime = "15s";
  
  console.useXkbConfig = true;

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
