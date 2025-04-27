{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    nixpkgs-kernel.url = "github:nixos/nixpkgs/cdd2ef009676ac92b715ff26630164bb88fec4e0";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, nixpkgs-kernel, home-manager, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}; # alias unstable packages to this variable
          pkgs-kernel = nixpkgs-kernel.legacyPackages.${system}; # alias unstable packages to this variable
        };
        modules = [
          ./machines/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nervousfish = {
                imports = [
                  ./common/users/nervousfish/home
                ];
              };
            };
          }
        ];
      };
    };
  };
}




