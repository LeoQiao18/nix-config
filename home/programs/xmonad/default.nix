{ pkgs, lib, ... }:

{
  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.xmonad-volume
      ];
      config = ./config.hs;
    };
  };
}
