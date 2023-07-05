{ config, pkgs, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    }; 
  };

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    coreutils
    xdg-utils
    discord
    vscode-fhs
    teams
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    libreoffice-qt
    git
    grim
    slurp
    swappy
    obs-studio
    wl-clipboard
    pavucontrol
    firefox
    hyprpaper
    unzip
    libva
    pamixer
    brightnessctl
    which
    cinnamon.nemo
    virt-manager
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  }; 

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
  	user = "nervousfish";
      };
      default_session = initial_session;
    };
  };

  security.pam.services.swaylock = {};

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "22.11";


  imports = [ ./nervousfish.nix ];
}
