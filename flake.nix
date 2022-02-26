{
  description = "Leo's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.xps-13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.dell-xps-13-9310
          ./system/machines/xps-13
          ./system/configuration.nix
        ];
      };

      homeConfigurations = (
        import ./outputs/home-conf.nix {
          inherit system nixpkgs home-manager;
        }
      );
    };
}
