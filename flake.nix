{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    # textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix, hyprland, nixvim, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs = import nixpkgs commonArgs;
      pkgs-unstable = import nixpkgs-unstable commonArgs;
      # spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
      # pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations.default = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/default/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.plasma = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/plasma/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.plasma-six = lib.nixosSystem {
        inherit pkgs;
        modules = [
	  ./hosts/plasma-six/configuration.nix 
	];
        specialArgs = { inherit pkgs-unstable; };
      };

      nixosConfigurations.hyprland = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/hyprland/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; inherit hyprland; };
      };

      homeConfigurations = {
        abrar = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home.nix
          ];
          extraSpecialArgs = { inherit pkgs-unstable spicetify-nix nixvim; };
        };
      };
    };
}
