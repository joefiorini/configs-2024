{
  description = "Home Manager configuration of joe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    nil.url = "github:oxalica/nil";
  };

  outputs = { nixpkgs, home-manager, nil, stylix, ... }:
    let
      system = "x86_64-linux";
      extras = {
        nil = nil;
      };
      pkgs = nixpkgs.legacyPackages.${system} // extras;
    in {
      homeConfigurations."joe" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ stylix.homeManagerModules.stylix ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
