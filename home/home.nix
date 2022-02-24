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
    tldr
  ];

  xmonadPkgs = with pkgs; [
    haskellPackages.xmobar
    networkmanager_dmenu
    nitrogen
  ];

  haskellPkgs = with pkgs; [
    haskellPackages.stack
    haskellPackages.brittany
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.hlint
    haskellPackages.haskell-language-server
    haskellPackages.hoogle
    haskellPackages.nix-tree
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

  imports = (import ./programs) ++ (import ./services);

  xdg.enable = true;

  home = {
    packages = defaultPkgs ++ xmonadPkgs ++ haskellPkgs ++ ocamlPkgs ++ scripts;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    fzf.enable = true;
    htop.enable = true;
    jq.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    ssh.enable = true;
  };
}
