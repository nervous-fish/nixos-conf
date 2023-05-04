{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfiguration = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x_86_64-linux";
	modules = [
          ./machines/laptop/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.nervousfish = import ./users/common/home.nix;
	  }
	];
      };
    };
  };
}




