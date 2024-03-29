{
  description = "Dither's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ...}: {
    nixosConfigurations = {
      "15s-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./system 
          ./hardware-configuration.nix

          home-manager.nixosModules.home-manager 
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.vardhan = import ./home;
          }
        ];
      };
    };
  };
}