{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall.enable = false;
  };

  virtualisation.docker.enable = true;

  security.rtkit.enable = true;

  time.timeZone = "Europe/Paris";
 
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
 
  nixpkgs.overlays = [
    (self: super: {
      fcitx-engines = pkgs.fcitx5;
    })
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15days";
    };
    settings = { 
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    }; 
  };

  nixpkgs.config.allowUnfree = true;  

  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    barrier
    vlc
    coreutils
    xdg-utils
    netcat
    discord
    vscode-fhs
    libreoffice-qt
    git
    obs-studio
    unzip
    libva
    protonvpn-gui
    which
    virt-manager
    psensor 
    gparted
    qbittorrent
    looking-glass-client
    mullvad-vpn
    ffsend
    onionshare-gui
    tor-browser-bundle-bin
    yt-dlp
    killall
    mpv
  ];

  services.mullvad-vpn.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  }; 

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma5.enable = true;
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 nervousfish qemu-libvirtd -"
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "22.11";


  imports = [ 
    ./pkgs
    ./nervousfish.nix
  ];
}
