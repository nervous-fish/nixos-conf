{ self, config, pkgs, pkgs-unstable, lib, ... }:

{
  system.nixos.label = "${config.system.nixos.version}-${self.sourceInfo.shortRev or "dirty"}";

  system.stateVersion = "22.11";

  networking = {
    hostName = "nixos";
    useDHCP = lib.mkForce true;
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
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  security.rtkit.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Paris";

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
  services.pulseaudio.enable = false;

  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    xkb.variant = "ergol";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.mullvad-vpn.enable = true;

  services.udev.extraRules = ''
    KERNEL=="ttyACM0", MODE="0666"
  ''; # bazecor

  services.ratbagd = {
    enable = true;
  };

  programs.appimage = {
    binfmt = true;
    enable = true;
  };

  programs.wireshark.enable = true;

  programs.fish.enable = true;

  environment.variables.EDITOR = "nvim";

  environment.systemPackages = (with pkgs; [
    android-tools
    anki
    barrier
    bitwig-studio
    burpsuite
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
    google-chrome
    gnome-tweaks
    gparted
    killall
    libratbag
    libreoffice-qt
    libva
    lm_sensors
    logseq
    looking-glass-client
    mpv
    mullvad-vpn
    nerd-fonts.fira-code
    netcat
    nixd
    nixfmt-rfc-style
    obs-studio
    onionshare-gui
    pinta
    piper
    protonvpn-gui
    qpwgraph
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
    parsec-bin
    qbittorrent
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    arcmenu
    blur-my-shell
    caffeine
    dash-to-panel
    gtile
    tiling-shell
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]);

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
      download-buffer-size = 524288000;
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

  imports = [
    ./users/nervousfish
  ];
}
