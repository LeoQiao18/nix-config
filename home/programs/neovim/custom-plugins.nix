{ buildVimPlugin }:

{
  fzf-hoogle = buildVimPlugin {
    name = "fzf-hoogle-vim";
    src = builtins.fetchTarball {
      name   = "fzf-hoogle-vim-v2.3.0";
      url    = "https://github.com/monkoose/fzf-hoogle.vim/archive/v2.3.0.tar.gz";
      sha256 = "00ay9250wdl8ym70dpv4zbs49g40dla6i48bk1zl95lp62kld4hr";
    };
  };

  vim-gtfo = buildVimPlugin {
    name = "vim-gtfo";
    src = builtins.fetchTarball {
      name   = "Vim-Gtfo-v2.0.0";
      url    = "https://github.com/justinmk/vim-gtfo/archive/2.0.0.tar.gz";
      sha256 = "0zq3pjdiahpq53g27rdd5jjfrz8kddqvm1jpsdqamkd1rjvrwr1y";
    };
  };

  vim-ripgrep = buildVimPlugin {
    name = "vim-ripgrep";
    src = builtins.fetchTarball {
      name   = "RipGrep-v1.0.2";
      url    = "https://github.com/jremmen/vim-ripgrep/archive/v1.0.3.tar.gz";
      sha256 = "0vzdi1q6xh440mvlgsi08d6py8n7ac2yhgixpcs74f4p9160zx1s";
    };
  };
}
