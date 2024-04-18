{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations.default = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/default/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      };
      nixosConfigurations.plasma = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/plasma/configuration.nix ];
        specialArgs = { inherit pkgs-unstable; };
      };

      homeConfigurations = {
        abrar = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
