{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    # Store credentials, e.b. WiFi passwords
    gnome3.gnome-keyring.enable = true;

    # Get system's power information, e.g. CPU usage
    upower.enable = true;
    systemd.services.upower.enable = true;

    # Allow concurrent communication between multiple processes
    dbus = {
      enable = true;
      socketActivated = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # X11
    xserver = {
      enable = true;
      startDbusSession = true;

      # Configure keymap
      layout = "us";

      # Enable touchpad support
      libinput.enable = true;

      displayManager.defaultSession = "none+xmonad";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
