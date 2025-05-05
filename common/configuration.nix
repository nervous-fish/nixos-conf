{ config, pkgs, pkgs-unstable, lib, ... }:

{
  imports = [ 
    ./users/nervousfish
  ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "nervousfish" ];
      PermitRootLogin = "no";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  }; 
  hardware.pulseaudio.enable = false;

  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    xkb.variant = "ergol";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  console.useXkbConfig = true;

  services.udev.extraRules = ''
    KERNEL=="ttyACM0", MODE="0666"
  ''; # bazecor

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  networking = {
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    resolvconf.enable = false;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall = {
      enable = true;
      interfaces.enp6s0.allowedTCPPorts = [  
        22
        24800 # barrier server
      ];
    };
  };
 
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

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

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      persistent = true;
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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

  environment.variables.EDITOR = "nvim";

  programs.appimage = {
    binfmt = true;
    enable = true;
  };

  programs.wireshark.enable = true;

  programs.fish.enable = true;

  environment.systemPackages = (with pkgs; [
    android-tools
    anki
    barrier
    busybox
    coreutils
    dbeaver-bin
    discord
    dracula-icon-theme
    dracula-theme
    ffmpeg_7
    ffsend
    filebot
    git
    gnome-tweaks
    gparted
    killall
    libratbag
    libreoffice-qt
    libva
    logseq
    looking-glass-client
    mpv
    mullvad-vpn
    netcat
    obs-studio
    onionshare-gui
    pinta
    piper
    protonvpn-gui
    shotcut
    stremio
    tor-browser-bundle-bin
    unzip
    virt-manager
    vlc
    vscode-fhs
    which
    wireshark
    xdg-utils
    yt-dlp
  ]) ++ (with pkgs-unstable; [
    bazecor
    qbittorrent
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    arcmenu
    blur-my-shell
    caffeine
    dash-to-panel
    gtile
    tiling-shell
    media-controls
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]);

  system.stateVersion = "22.11";
}
