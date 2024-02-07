{ pkgs, stdenv, lib, fetchFromGithub }:
{
   sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "v${version}";
      sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };

  wargames = stdenv.mkDerivation rec {
    pname = "sddm-wargames-theme";
    version = "1.0";
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/wargames
    '';
    src = pkgs.fetchFromGitHub {
      owner = "nervous-fish";
      repo = "sddm-wargames-theme";
      rev = "5076a1ef84b1509ab57b74c3ade848b01f613dff";
      sha256 = "sha256-NaNMFOqXNNltQoKL0C39auP1o7EkbfF/lPPuMz9dy7A=";
    };
  };


  nosddm = stdenv.mkDerivation rec {
    pname = "sddm-nosddm-theme";
    version = "1.2.0";
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/nosddm
    '';
    src = pkgs.fetchFromGitHub {
      owner = "nervous-fish";
      repo = "where-is-my-sddm-theme";
      rev = "136ba5793993deb60b878990181383b0c2f47a04";
      sha256 = "sha256-ESEfMUjSug7nLSaTb7m1vBglnNW8lj4vkIl2+GFEvss=";
    };
  };
}
