{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      nrb = "sudo nixos-rebuild boot --flake";
      nrs = "sudo nixos-rebuild switch --flake";
      virstart = "virsh --connect qemu:///system start"; 
      virstop = "virsh --connect qemu:///system shutdown";
    };
  };
}
