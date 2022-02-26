# Configuration for the display of the xps-13 laptop (default: xps-13)
{ config, lib, pkgs, ... }:

let
  #base = pkgs.callPackage ../home.nix { inherit config lib pkgs; };

  laptopBar = pkgs.callPackage ../programs_scaled/polybar/bar.nix {
    font0 = 10;
    font1 = 12;
    font2 = 24;
    font3 = 18;
    font4 = 5;
    font5 = 10;
  };

  statusBar = import ../programs_scaled/polybar/default.nix {
    inherit config pkgs;
    mainBar = laptopBar;
    openCalendar = "";
  };

  myspotify = import ../programs_scaled/spotify/default.nix { inherit pkgs; opts = ""; };

  terminal = import ../programs_scaled/alacritty/default.nix { fontSize = 8; inherit pkgs; };

  wm = import ../programs_scaled/xmonad/default.nix {
    inherit config pkgs lib;
  };
in
{
  imports = [
    ../home.nix
    statusBar
    terminal
    wm
  ];

  home.packages = [ myspotify ];
}
