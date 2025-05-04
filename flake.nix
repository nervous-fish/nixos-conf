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

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, nixpkgs-kernel, home-manager, ... }: let 
    getSpecialArgs = system: {
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-27.3.11"
        ];
      };
      
      pkgs-kernel = import nixpkgs-kernel {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      desktop = let system = "x86_64-linux"; in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = getSpecialArgs system;
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




