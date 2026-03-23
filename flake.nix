{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    personal-home-manager = {
      url = "github:dddictionary/home-manager";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim-config = {
      url = "github:dddictionary/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, personal-home-manager, spicetify-nix, hyprland, nixvim-config, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      commonArgs = { inherit system; config.allowUnfree = true; };
      pkgs = import nixpkgs commonArgs;
      pkgs-unstable = import nixpkgs-unstable commonArgs;
    in {
      # All targets use the same host — swap desktop by editing imports in configuration.nix
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/nixos/configuration.nix ];
        specialArgs = { inherit pkgs-unstable hyprland; };
      };

      homeConfigurations = {
        abrar = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            "${personal-home-manager}/home.nix"
          ];
          extraSpecialArgs = {
            inherit pkgs-unstable spicetify-nix nixvim-config;
            system = "x86_64-linux";
            homeDirectory = "/home/abrar";
          };
        };
      };
    };
}
