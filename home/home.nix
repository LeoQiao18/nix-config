{ config, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    arandr               # simple GUI for xrandr
    betterlockscreen     # lock screen
    coreutils            # basic tools like cat, ls, rm
    dmenu                # application launcher
    fd                   # "find" for files
    gawk                 # gnu awk
    killall              # kill process by name
    libnotify            # notify-send command
    pandoc               # convert markup
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    pavucontrol          # pulseaudio volume control
    playerctl            # music player controller
    pulsemixer           # pulseaudio mixer
    ripgrep              # fast grep
    rnix-lsp             # nix lsp server
    slack                # messaging client
    tldr                 # summary of a man page
    tree                 # display files in tree view
    vlc                  # media player
    xsel                 # clipboard support
  ];

  xmonadPkgs = with pkgs; [
    networkmanager_dmenu
    networkmanagerapplet
    nitrogen
    xorg.xrandr
  ];

  polybarPkgs = with pkgs; [
    font-awesome-ttf
    material-design-icons
    siji
  ];

  gnomePkgs = with pkgs; [
    gnome3.eog            # image viewer
    gnome3.evince         # pdf reader
    gnome3.gnome-calendar # calendar
    gnome3.nautilus       # file manager
  ];

  haskellPkgs = with pkgs; [
    haskellPackages.brittany
    haskellPackages.cabal-install
    haskellPackages.cabal2nix
    haskellPackages.ghc
    haskellPackages.haskell-language-server
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.nix-tree
    haskellPackages.stack
  ];

  ocamlPkgs = with pkgs; [
    ocamlPackages.ocaml
    ocamlPackages.ocaml-lsp
    ocamlformat
    opam
  ];

  scripts = pkgs.callPackage ./scripts/default.nix { inherit config pkgs; };
in
{
  programs.home-manager.enable = true;

  imports = (import ./programs);

  xdg.enable = true;

  home = {
    packages = defaultPkgs ++ xmonadPkgs ++ polybarPkgs ++ gnomePkgs ++ haskellPkgs ++ ocamlPkgs ++ scripts;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";

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

  services = {
    # screenshot utility
    flameshot.enable = true;
  };
}
