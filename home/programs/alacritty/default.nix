{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };
      colors = {
        primary = {
          background = "#040404";
          foreground = "#c5c8c6";
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Medium";
        };
        size = 8;
      };
      window = {
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
        opacity = 0.8;
      };
      mouse = {
        hints = {
          launcher = {
            program = "xdg-open";
          };
        };
      };
    };
  };
}
