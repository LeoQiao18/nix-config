{ config, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    arandr
    fd
    xsel
    gawk
    coreutils
    ripgrep
    rnix-lsp
    slack
    tree
    vlc
    dmenu
    betterlockscreen
    killall
    pandoc
    tldr
  ];

  xmonadPkgs = with pkgs; [
    haskellPackages.xmobar
    networkmanager_dmenu
    nitrogen
    xorg.xrandr
  ];

  polybarPkgs = with pkgs; [
    font-awesome-ttf
    material-design-icons
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

  imports = (import ./programs);

  xdg.enable = true;

  home = {
    packages = defaultPkgs ++ xmonadPkgs ++ polybarPkgs ++ haskellPkgs ++ ocamlPkgs ++ scripts;

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
