{ config, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    fd
    xsel
    nodejs
    yarn
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
in
{
  programs.home-manager.enable = true;

  imports = (import ./programs);

  home.packages = defaultPkgs ++ haskellPkgs;

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
