{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-unimpaired
      vim-vinegar
      vim-easymotion
      vim-tmux-navigator
      vim-surround
      nerdcommenter
      gruvbox
      fzf-vim
      coc-nvim
    ];
    settings = {
      expandtab = true;
      shiftwidth = 2;
      ignorecase = true;
      number = true;
    };
    extraConfig = ''
      syntax enable
      set background=dark
      colorscheme gruvbox

      nnoremap <C-p> :Files<Cr>
    '';
  };
}
