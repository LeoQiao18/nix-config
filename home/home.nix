{ config, pkgs, ... }:
{
  
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fd
    xsel
    slack
  ];

  imports = (import ./programs);
}
