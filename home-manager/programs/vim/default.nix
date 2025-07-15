_: {
  programs.vim = {
    enable = true;

    # Disable viminfo file creation
    extraConfig = ''
      " Disable viminfo file
      set viminfo=

      " Alternative: Move viminfo to a hidden directory
      " set viminfo+=n~/.cache/vim/viminfo

      " Basic vim settings
      set nocompatible
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set autoindent
      set smartindent
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set showmatch
      set wildmenu
      set wildmode=longest,list,full

      " Disable backup and swap files
      set nobackup
      set nowritebackup
      set noswapfile

      " Enable syntax highlighting
      syntax on
      filetype plugin indent on
    '';
  };
}
