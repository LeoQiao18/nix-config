{ config, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    fd
    xsel
    slack
    spotify
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    brittany
    cabal2nix
    cabal-install
    ghc
    haskell-language-server
    hoogle
    nix-tree
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };
in
{
  programs.home-manager.enable = true;

  imports = (import ./programs);

  xdg.enable = true;

  home.packages = defaultPkgs ++ haskellPkgs ++ scripts;

  programs = {
    fzf.enable = true;
    htop.enable = true;
    jq.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
  };
}
