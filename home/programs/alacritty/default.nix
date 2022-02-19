{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 0.8;
      font = {
        size = 16;
      };
      window = {
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
