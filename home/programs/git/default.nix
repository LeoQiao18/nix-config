{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "vim";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool = "vim_mergetool";
    };
    pull.rebase = true;
  };
in
  {
    programs.git = {
      enable = true;
      userEmail = "qiaofeitong@hotmail.com";
      userName = "LeoQiao18";
      extraConfig = gitConfig;
      ignores = [
        "*.direnv"
      ];
    };
  }
