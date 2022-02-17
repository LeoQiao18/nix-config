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

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager }: {
    nixosConfigurations.xps-13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9310
        ./system/machines/xps-13
      ];
    };

    homeConfigurations.lqiao = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      homeDirectory = "/home/lqiao";
      username = "lqiao";
      stateVersion = "21.05";
      configuration = { config, pkgs, ...}:
        {
          nixpkgs.config = {
            allowUnfree = true;
            allowBroken = true;
          };

          imports = [
            ./home/home.nix
          ];
        };
    };

    lqiao = self.homeConfigurations.lqiao.activationPackage;
  };
}
