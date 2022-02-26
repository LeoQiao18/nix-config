{ mainBar, openCalendar, config, pkgs, ... }:

let
  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    pulseSupport = true;
    mpdSupport = true;
  };

  openCalendar = "";

  bars = builtins.readFile ./bars.ini;
  colors = builtins.readFile ./colors.ini;
  mods1  = builtins.readFile ./modules.ini;
  mods2  = builtins.readFile ./user_modules.ini;

  bluetoothScript = pkgs.callPackage ./scripts/bluetooth.nix {};
  #klsScript       = pkgs.callPackage ../../scripts/keyboard-layout-switch.nix { inherit pkgs; };
  monitorScript   = pkgs.callPackage ./scripts/monitor.nix {};
  mprisScript     = pkgs.callPackage ./scripts/mpris.nix {};
  networkScript   = pkgs.callPackage ./scripts/network.nix {};

  bctl = ''
    [module/bctl]
    type = custom/script
    exec = ${bluetoothScript}/bin/bluetooth-ctl
    tail = true
    click-left = ${bluetoothScript}/bin/bluetooth-ctl --toggle &
  '';

  cal = ''
    [module/clickable-date]
    inherit = module/date
    label = %{A1:${openCalendar}:}%time%%{A}
  '';

  #github = ''
    #[module/clickable-github]
    #inherit = module/github
    #token = ''${file:${config.xdg.configHome}/polybar/github-notifications-token}
    #user = LeoQiao18
    #label = %{A1:${openGithub}:}  %notifications%%{A}
  #'';

  keyboard = ''
    [module/clickable-keyboard]
    inherit = module/keyboard
    label-layout =   %layout% %icon%
  '';

  mpris = ''
    [module/mpris]
    type = custom/script
    exec = ${mprisScript}/bin/mpris
    tail = true
    label-maxlen = 60
    interval = 2
    format =   <label>
    format-padding = 2
  '';

  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
    tail = true
  '';

  customMods = mainBar + bctl + cal + keyboard + mpris + xmonad;
in
{
  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;
    extraConfig = bars + colors + mods1 + mods2 + customMods;
    script = ''
      killall -q polybar
      polybar top 2>&1 | tee -a /tmp/polybarTop.log & disown
      polybar bottom 2>&1 | tee -a /tmp/polybarBottom.log & disown
    '';
  };
}
