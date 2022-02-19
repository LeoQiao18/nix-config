{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    # Store credentials, e.b. WiFi passwords
    gnome.gnome-keyring.enable = true;

    # Get system's power information, e.g. CPU usage
    upower.enable = true;

    # Allow concurrent communication between multiple processes
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    # X11
    xserver = {
      enable = true;

      # Configure keymap
      layout = "us";

      # Enable touchpad support
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  systemd.services.upower.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
