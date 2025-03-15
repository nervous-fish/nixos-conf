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
        22
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
    kmonad-toggle
    media-controls
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]);

  programs.appimage.binfmt = true;
  programs.appimage.enable = true;

  programs.wireshark.enable = true;

  services.mullvad-vpn.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "nervousfish" ];
      PermitRootLogin = "no";
    };
  };

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
