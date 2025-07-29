{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-kernel.url = "github:nixos/nixpkgs/c26ebd7b372062034a96846219b25cea95173981";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-kernel, home-manager, ... }: let
    getSpecialArgs = system: {
      inherit self;

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

    homeConfigurations = {
      "nervousfish" = let
          system = "x86_64-linux";
          args = getSpecialArgs system;
      in home-manager.lib.homeManagerConfiguration {
        pkgs = args.pkgs;
        modules = [ ./common/users/nervousfish/home ];
        extraSpecialArgs = args;
      };
    };
  };
}




