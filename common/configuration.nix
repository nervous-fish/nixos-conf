{ config, pkgs, pkgs-unstable, lib, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall.enable = false;
  };

  services.xserver.xkb.extraLayouts.optimot = {
    description = "Optimot v1.8";
    languages   = [ "fra" "eng" ];
    symbolsFile = pkgs.writeText "optimot-xkb-symbols" ''
      partial alphanumeric_keys
      xkb_symbols "optimot" {

              name[Group1]= "France - Optimot Ergo v1.8.0";

              include "latin"

              key <TLDE> { type[group1] = "FOUR_LEVEL_CONTROL", [ dollar, EuroSign, dead_currency, copyright, dollar, dollar ] }; // $ € ¤ ©
              key <AE01> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ guillemotleft, 1, leftdoublequotemark, onequarter, 1, 1 ] }; // « 1 “ ¼
              key <AE02> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ guillemotright, 2, rightdoublequotemark, onehalf, 2, 2 ] }; // » 2 ” ½
              key <AE03> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ quotedbl, 3, doublelowquotemark, threequarters, 3, 3 ] }; // " 3 „ ¾
              key <AE04> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ minus, 4, U2011, onethird, 4, 4 ] }; // - 4 ‑ ⅓
              key <AE05> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ plus, 5, plusminus, twothirds, 5, 5 ] }; // + 5 ± ⅔
              key <AE06> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ asterisk, 6, multiply, U273B, 6, 6 ] }; // * 6 × ✻
              key <AE07> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ slash, 7, backslash, division, 7, 7 ] }; // / 7 \ ÷
              key <AE08> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ equal, 8, notequal, U2248, 8, 8 ] }; // = 8 ≠ ≈
              key <AE09> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ parenleft, 9, bracketleft, minutes, 9, 9 ] }; // ( 9 [ ′
              key <AE10> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ parenright, 0, bracketright, seconds, 0, 0 ] }; // ) 0 ] ″
              key <AE11> { type[group1] = "FOUR_LEVEL_CONTROL", [ at, underscore, U2212, figdash, minus, minus ] }; // @ _ − ‒
              key <AE12> { type[group1] = "FOUR_LEVEL_CONTROL", [ numbersign, percent, degree, masculine, plus, plus ] }; // # % ° º
              key <AD01> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ agrave, Agrave, less, U2A7D, q, q ] }; // à À < ⩽
              key <AD02> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ j, J, greater, U2A7E, j, j ] }; // j J > ⩾
              key <AD03> { type[group1] = "FOUR_LEVEL_ALPHABETIC_CONTROL", [ o, O, oe, OE, o, o ] }; // o O œ Œ
              key <AD04> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ eacute, Eacute, dead_acute, Cyrillic_zhe, x, x ] }; // é É ´ ж
              key <AD05> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ b, B, emdash, U274F, b, b ] }; // b B — ❏
              key <AD06> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ f, F, leftsinglequotemark, U2726, f, f ] }; // f F ‘ ✦
              key <AD07> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ d, D, braceleft, dagger, d, d ] }; // d D { †
              key <AD08> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ l, L, braceright, doubledagger, l, l ] }; // l L } ‡
              key <AD09> { type[group1] = "FOUR_LEVEL_CONTROL", [ apostrophe, question, rightsinglequotemark, questiondown, semicolon, semicolon ] }; // ' ? ’ ¿
              key <AD10> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ q, Q, dead_abovering, U2E2E, q, q ] }; // q Q ˚ ⸮
              key <AD11> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ x, X, bar, registered, x, x ] }; // x X | ®
              key <AD12> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ z, Z, rightarrow, trademark, z, z ] }; // z Z → ™
              key <AC01> { type[group1] = "FOUR_LEVEL_ALPHABETIC_CONTROL", [ a, A, ae, AE, a, a ] }; // a A æ Æ
              key <AC02> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ i, I, downarrow, section, i, i ] }; // i I ↓ §
              key <AC03> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ e, E, uparrow, paragraph, e, e ] }; // e E ↑ ¶
              key <AC04> { type[group1] = "FOUR_LEVEL_ALPHABETIC_CONTROL", [ u, U, ugrave, Ugrave, u, u ] }; // u U ù Ù
              key <AC05> { type[group1] = "FOUR_LEVEL_CONTROL", [ comma, semicolon, endash, checkmark, comma, comma ] }; // , ; – ✓
              key <AC06> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ p, P, grave, U2605, p, p ] }; // p P ` ★
              key <AC07> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ t, T, ampersand, U2B05, t, t ] }; // t T & ⬅
              key <AC08> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ s, S, infinity, U2B07, s, s ] }; // s S ∞ ⬇
              key <AC09> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ r, R, Lcaron, U2B06, r, r ] }; // r R Ľ ⬆
              key <AC10> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ n, N, dead_tilde, U27A1, n, n ] }; // n N ~ ➡
              key <AC11> { type[group1] = "FOUR_LEVEL_CONTROL", [ dead_circumflex, exclam, dead_diaeresis, exclamdown, a, a ] }; // ^ ! ¨ ¡
              key <BKSL> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ ccedilla, Ccedilla, dead_horn, U1F12F, w, w ] }; // ç Ç ̛ 🄯
              key <LSGT> { type[group1] = "FOUR_LEVEL_CONTROL", [ dead_caron, dead_cedilla, asciitilde, U2248, z, z ] }; // ˇ ¸ ~ ≈
              key <AB01> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ k, K, oslash, U2388, k, k ] }; // k K ø ⎈
              key <AB02> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ y, Y, dead_abovedot, U2325, y, y ] }; // y Y ˙ ⌥
              key <AB03> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ egrave, Egrave, dead_grave, U2318, c, c ] }; // è È ` ⌘
              key <AB04> { type[group1] = "FOUR_LEVEL_CONTROL", [ period, colon, ellipsis, periodcentered, v, v ] }; // . : … ·
              key <AB05> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ w, W, U2022, ballotcross, w, w ] }; // w W • ✗
              key <AB06> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ g, G, mu, U2723, g, g ] }; // g G µ ✣
              key <AB07> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ c, C, dead_cedilla, U2660, c, c ] }; // c C ¸ ♠
              key <AB08> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ m, M, dead_macron, heart, m, m ] }; // m M ¯ ♥
              key <AB09> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ h, H, dead_breve, diamond, h, h ] }; // h H ˘ ♦
              key <AB10> { type[group1] = "FOUR_LEVEL_SEMIALPHABETIC_CONTROL", [ v, V, dead_caron, club, v, v ] }; // v V ˇ ♣
              key <SPCE> { type[group1] = "FOUR_LEVEL_CONTROL", [ space, U202F, nobreakspace, hyphen, space, space ] }; //       ­

              include "level3(ralt_switch)"
      };
    '';
    typesFile = pkgs.writeText "optimot-xkb-types" ''
      xkb_types "optimot" { 
          include "complete"

          type "FOUR_LEVEL_CONTROL" {
              modifiers = Shift+LevelThree+Control;
              
              map[None] = Level1;
              map[Shift] = Level2;
              map[LevelThree] = Level3;
              map[Shift+LevelThree] = Level4;
              map[Control]  = Level5;
              map[Control+Shift] = Level6;

              preserve[Control] = Control;
              preserve[Shift+Control] = Control;
              
              level_name[Level1] = "Base";
              level_name[Level2] = "Shift";
              level_name[Level3] = "Alt Base";
              level_name[Level4] = "Shift Alt";
              level_name[Level5] = "Control";
              level_name[Level6] = "Shift Control";
          };

          type "FOUR_LEVEL_ALPHABETIC_CONTROL" {
              modifiers = Shift+Lock+LevelThree+Control;
              
              map[None] = Level1;
              map[Shift] = Level2;
              map[Lock]  = Level2;
              map[LevelThree] = Level3;
              map[Shift+LevelThree] = Level4;
              map[Lock+LevelThree] =  Level4;
              map[Lock+Shift+LevelThree] =  Level3;
              map[Control]  = Level5;
              map[Control+Shift] = Level6;

              preserve[Control] = Control;
              preserve[Shift+Control] = Control;
              
              level_name[Level1] = "Base";
              level_name[Level2] = "Shift";
              level_name[Level3] = "Alt Base";
              level_name[Level4] = "Shift Alt";
              level_name[Level5] = "Control";
              level_name[Level6] = "Shift Control";
          };

          type "FOUR_LEVEL_SEMIALPHABETIC_CONTROL" {
              modifiers = Shift+Lock+LevelThree+Control;
              
              map[None] = Level1;
              map[Shift] = Level2;
              map[Lock]  = Level2;
              map[LevelThree] = Level3;
              map[Shift+LevelThree] = Level4;
              map[Lock+LevelThree] =  Level3;
              map[Lock+Shift+LevelThree] = Level4;
              map[Control]  = Level5;
              map[Control+Shift] = Level6;
              
              preserve[Control] = Control;
              preserve[Shift+Control] = Control;
              preserve[Lock+LevelThree] = Lock;
              preserve[Lock+Shift+LevelThree] = Lock;
              
              level_name[Level1] = "Base";
              level_name[Level2] = "Shift";
              level_name[Level3] = "Alt Base";
              level_name[Level4] = "Shift Alt";
              level_name[Level5] = "Control";
              level_name[Level6] = "Shift Control";
          };
                  
      };
    '';
    keycodesFile = pkgs.writeText "optimot-xkb-keycodes" ''
      xkb_keycodes "optimot" { include "evdev+aliases(azerty)" };
    '';
    compatFile = pkgs.writeText "optimot-xkb-compat" ''
      xkb_compatibility "optimot" { include "complete" };
    '';
    geometryFile = pkgs.writeText "optimot-xkb-geometry" ''
      xkb_geometry "optimot" { include "latin" };
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

  environment.systemPackages = (with pkgs; [
    barrier
    vlc
    coreutils
    dbeaver
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
  ]) ++ (with pkgs-unstable; [
    bazecor
  ]) ++ (with pkgs.gnome; [
    gnome-color-manager
  ]) ++ (with pkgs.gnomeExtensions; [
    dash-to-panel
    arcmenu
    blur-my-shell
    caffeine
    media-controls
    appindicator
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

  programs.steam = {
    enable = true;
  };

  services.mullvad-vpn.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  }; 
  hardware.pulseaudio.enable = false;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
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
