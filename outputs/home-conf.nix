{ system, nixpkgs, home-manager, ... }:

let
  username = "lqiao";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
    config.xdg.configHome = configHome;
  };

  mkHome = conf: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs system username homeDirectory;

      stateVersion = "21.05";
      configuration = conf;
    });

  edpConf = import ../home/displays/edp.nix {
    inherit pkgs;
    inherit (pkgs) config lib stdenv;
  };
in
{
  lqiao-edp = mkHome edpConf;
}
