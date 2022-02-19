{ config, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    fd
    xsel
    gawk
    coreutils
    ripgrep
    rnix-lsp
    slack
    spotify
    tree
    vlc
    dmenu
    killall
    pandoc
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    stack
    brittany
    cabal2nix
    cabal-install
    ghc
    hlint
    haskell-language-server
    hoogle
    nix-tree
  ];

  ocamlPkgs = with pkgs; [
    opam
    ocamlformat
    ocamlPackages.ocaml
    ocamlPackages.ocaml-lsp
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };
in
{
  programs.home-manager.enable = true;

  imports = (import ./programs);

  xdg.enable = true;

  home.packages = defaultPkgs ++ haskellPkgs ++ ocamlPkgs ++ scripts;

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
