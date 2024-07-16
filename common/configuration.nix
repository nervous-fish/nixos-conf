{ config, pkgs, pkgs-unstable, fh, lib, ... }:

{
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
        53842 # gokapi
      ];
    };
  };

  services.xserver.xkb.extraLayouts.qwerty-fr = {
    description = "qwerty-fr";
    languages   = [ "eng" ];
    symbolsFile = pkgs.writeText "qwerty-fr-symbols" ''
      partial alphanumeric_keys 
      xkb_symbols "qwerty-fr"
      {
          include "us(basic)"
          include "level3(ralt_switch)"

          name[Group1]= "US keyboard with french symbols - AltGr combination";

          key <TLDE> { [ grave,        asciitilde,  dead_grave,             dead_tilde           ] };
          key <AE01> { [ 1,            exclam,      onesuperior,            exclamdown           ] };
          key <AE02> { [ 2,            at,          twosuperior,            dead_doubleacute     ] };
          key <AE03> { [ 3,            numbersign,  ecircumflex,            Ecircumflex          ] };
          key <AE04> { [ 4,            dollar,      EuroSign,               dead_currency        ] }; // FIXME: dead_currency has a different mapping than the one we want for qwerty-fr. Need to define a custom dead key instead. See Windows layout for dead key definition.
          key <AE05> { [ 5,            percent,     dead_macron,            dead_abovedot        ] };
          key <AE06> { [ 6,            asciicircum, dead_circumflex,        dead_caron           ] };
          key <AE07> { [ 7,            ampersand,   ucircumflex,            Ucircumflex          ] };
          key <AE08> { [ 8,            asterisk,    icircumflex,            Icircumflex          ] };
          key <AE09> { [ 9,            parenleft,   ocircumflex,            Ocircumflex          ] };
          key <AE10> { [ 0,            parenright,  oslash,                 Oslash               ] };
          key <AE11> { [ minus,        underscore,  endash,                 emdash               ] };
          key <AE12> { [ equal,        plus,        notequal,               approxeq             ] };
          
          key <AD01> { [ q,            Q,           acircumflex,            Acircumflex          ] };
          key <AD02> { [ w,            W,           eacute,                 Eacute               ] };
          key <AD03> { [ e,            E,           egrave,                 Egrave               ] };
          key <AD04> { [ r,            R,           registered,             copyright            ] };
          key <AD05> { [ t,            T,           thorn,                  THORN                ] };
          key <AD06> { [ y,            Y,           dead_invertedbreve,     dead_breve           ] };
          key <AD07> { [ u,            U,           ugrave,                 Ugrave               ] };
          key <AD08> { [ i,            I,           igrave,                 Igrave               ] };
          key <AD09> { [ o,            O,           ograve,                 Ograve               ] };
          key <AD10> { [ p,            P,           oe,                     OE                   ] };
          key <AD11> { [ bracketleft,  braceleft,   guillemotleft,          leftdoublequotemark  ] };
          key <AD12> { [ bracketright, braceright,  guillemotright,         rightdoublequotemark ] };

          key <AC01> { [ a,            A,           agrave,                 Agrave               ] };
          key <AC02> { [ s,            S,           ae,                     AE                   ] };
          key <AC03> { [ d,            D,           ediaeresis,             Ediaeresis           ] };
          key <AC04> { [ f,            F,           VoidSymbol,             VoidSymbol           ] };
          key <AC05> { [ g,            G,           dead_greek,             VoidSymbol           ] }; // FIXME: dead_greek has a different mapping than the one we want for qwerty-fr. Need to define a custom dead key instead. See Windows layout for dead key definition.
          key <AC06> { [ h,            H,           ydiaeresis,             Ydiaeresis           ] };
          key <AC07> { [ j,            J,           udiaeresis,             Udiaeresis           ] };
          key <AC08> { [ k,            K,           idiaeresis,             Idiaeresis           ] };
          key <AC09> { [ l,            L,           odiaeresis,             Odiaeresis           ] };
          key <AC10> { [ semicolon,    colon,       dead_acute,             dead_abovering       ] };
          key <AC11> { [ apostrophe,   quotedbl,    dead_grave,             dead_diaeresis       ] };
          key <BKSL> { [ backslash,    bar,         VoidSymbol,             doublelowquotemark   ] }; // „

          key <LSGT> { [ less,         greater,     lessthanequal,          greaterthanequal     ] };
          key <AB01> { [ z,            Z,           adiaeresis,             Adiaeresis           ] };
          key <AB02> { [ x,            X,           multiply,               division             ] };
          key <AB03> { [ c,            C,           ccedilla,               Ccedilla             ] };
          key <AB04> { [ v,            V,           VoidSymbol,             VoidSymbol           ] };
          key <AB05> { [ b,            B,           ssharp,                 U1E9E                ] }; // ß, ẞ (capital)
          key <AB06> { [ n,            N,           ntilde,                 Ntilde               ] };
          key <AB07> { [ m,            M,           VoidSymbol,             VoidSymbol           ] };
          key <AB08> { [ comma,        less,        dead_cedilla,           dead_ogonek          ] };
          key <AB09> { [ period,       greater,     periodcentered,         ellipsis             ] }; // ., >, ·, …
          key <AB10> { [ slash,        question,    rightsinglequotemark,   questiondown         ] }; // /, ?, ’, ¿
          key <SPCE> { [ space,        space,       nobreakspace,           0x100202F            ] }; // espace insécable fine

      }; 
    '';
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
    android-tools
    wireshark
    busybox
  ]) ++ (with pkgs-unstable; [
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
  ];
}
