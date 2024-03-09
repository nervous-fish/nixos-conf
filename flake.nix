{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };  
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          ./machines/laptop
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
              useGlobalPkgs = true;
	      useUserPackages = true;
	      users.nervousfish = {
	        imports = [
	          ./common/home
                ];
              };
	    };
	  }
	];
      };
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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




