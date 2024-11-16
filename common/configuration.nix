{ config, pkgs, pkgs-unstable, fh, lib, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    resolvconf.enable = false;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall = {
      enable = true;
      interfaces.enp6s0.allowedTCPPorts = [  
        24800 # barrier server
      ];
    };
  };
 
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      mtu = 1500;
    };
  };

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

  nixpkgs.config.allowUnfree = true;  

  environment.variables.EDITOR = "nvim";

  environment.systemPackages = [
    fh.packages.x86_64-linux.default 
  ] ++ (with pkgs; [
    barrier
    dracula-theme
    dracula-icon-theme
    vlc
    coreutils
    dbeaver-bin
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
    libratbag
    piper
    pinta
    shotcut
    ffmpeg_7
    android-tools
    wireshark
    busybox
    logseq
    filebot
    anki
  ]) ++ (with pkgs-unstable; [
    bazecor
  ]) ++ (with pkgs.gnome; [
    gnome-tweaks
  ]) ++ (with pkgs.gnomeExtensions; [
    dash-to-panel
    arcmenu
    blur-my-shell
    caffeine
    media-controls
    appindicator
    gtile
    kmonad-toggle
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  programs.wireshark.enable = true;

  services.mullvad-vpn.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  }; 
  hardware.pulseaudio.enable = false;

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    desktopManager.gnome.enable = true;
  };

  services.ratbagd = {
    enable = true;
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 nervousfish qemu-libvirtd -"
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "22.11";


  imports = [ 
    ./nervousfish.nix
    ./keyboards
  ];
}
