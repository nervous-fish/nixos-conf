{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          ./machines/laptop
	  hyprland.nixosModules.default 
          {
            programs.hyprland.enable = true;
          }
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
              useGlobalPkgs = true;
	      useUserPackages = true;
	      users.nervousfish = {
	        imports = [
	          hyprland.homeManagerModules.default
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
          hyprland.nixosModules.default 
          {
            programs.hyprland.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nervousfish = {
                imports = [
                  hyprland.homeManagerModules.default
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




