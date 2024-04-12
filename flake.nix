{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
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
                  ./machines/desktop/home
                ];
              };
            };
          }
        ];
      };
    };
  };
}




