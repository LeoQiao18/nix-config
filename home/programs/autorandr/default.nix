{ pkgs, ... }:

let
  xps13-id = "00ffffffffffff004d10f91400000000151e0104a51d12780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360020b410000018203080a070b023403020360020b410000018000000fe0056564b3859804c513133344e31000000000002410332001200000a010a20200080";
  lg27-1-id = "00ffffffffffff001e6d0777b9a404000a1e0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a20202001030203197144900403012309070783010000e305c000e3060501023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
  lg27-2-id = "00ffffffffffff001e6d0777a0e20400061c0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a20202001e40203197144900403012309070783010000e305c000e3060501023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";

  notify = "${pkgs.libnotify}/bin/notify-send";
in
{
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify-xmonad" = ''
          ${notify} -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
        '';

        #"change-dpi" = ''
          #case "$AUTORANDR_CURRENT_PROFILE" in
            #away)
              #DPI=169
              #;;
            #home)
              #DPI=96
              #;;
            #*)
              #${notify} -i display "Unknown profile: $AUTORANDR_CURRENT_PROFILE"
              #exit 1
          #esac
          #echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        #'';
      };
    };

    profiles = {
      "away" = {
        fingerprint = {
          eDP-1 = xps13-id;
        };

        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rate = "59.95";
            rotate = "normal";
          };
        };
      };

      "home" = {
        fingerprint = {
          eDP-1 = xps13-id;
          DP-1 = lg27-1-id;
        };

        config = {
          eDP-1.enable = false;

          DP-1 = {
            enable = true;
            crtc = 0;
            position = "0x0";
            mode = "3840x2160";
            rate = "60.00";
            rotate = "normal";
            scale = {
              x = 2;
              y = 2;
            };
          };
        };
      };
    };
  };
}
