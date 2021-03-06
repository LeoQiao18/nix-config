{ config, pkgs, ... }:

let
  customPlugins = pkgs.callPackage ./custom-plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };
  plugins = pkgs.vimPlugins // customPlugins;
  myPlugins = with plugins; [
      vim-airline
      vim-unimpaired
      vim-vinegar
      vim-easymotion
      vim-tmux-navigator
      vim-surround
      nerdcommenter
      gruvbox
      fzf-vim
      fzf-hoogle
      coc-nvim
      vim-nix
      vim-tmux
      vim-css-color
      vim-which-key
      vim-gtfo
      vim-ripgrep
      fzf-hoogle
    ];
  cocSettings = builtins.toJSON (import ./coc-settings.nix);
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = myPlugins;
    extraConfig = ''
      syntax enable
      set background=dark
      colorscheme gruvbox

      set expandtab
      set shiftwidth=2
      set ignorecase
      set number

      let mapleader="\<space>"
      nnoremap <C-p> :Files<Cr>
    '';
  };

  xdg.configFile = {
    "nvim/coc-settings.json".text = cocSettings;
  };
}
