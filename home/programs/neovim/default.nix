{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
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
