"
" Begin Vundle configuration
"
set nocompatible                      " Be iMproved

filetype off

set rtp+=~/.Vundle/Vundle.vim         " Set the runtime path to inclue Vundle
call vundle#begin("~/.Vundle")        " Init Vundle

Plugin 'VundleVim/Vundle.vim'         " Let Vundle manage Vundle

" List plugins managed by Vundle
Plugin 'qpkorr/vim-bufkill'           " Kill a buffer without closing a window or split
Plugin 'scrooloose/nerdtree'          " Filetree browser
Plugin 'scrooloose/nerdcommenter'     " Commenter
Plugin 'scrooloose/syntastic'         " Syntax checker
Plugin 'kien/ctrlp.vim'               " Fast file navigation
Plugin 'jlanzarotta/bufexplorer'      " Buffer explorer
Plugin 'tpope/vim-fugitive'           " Git repository management
Plugin 'tpope/vim-surround'           " Manipulate 'surroundings' (parentheses, brackets, ...)
Plugin 'majutsushi/tagbar'            " Class browser
Plugin 'freeo/vim-kalisi'             " Colorscheme
Plugin 'MarcWeber/vim-addon-mw-utils' " Dependency for vim-snipmate
Plugin 'tomtom/tlib_vim'              " Dependency for vim-snipmate
Plugin 'garbas/vim-snipmate'          " Text and code templates
Plugin 'godlygeek/tabular'            " Text aligning
Plugin 'sjl/gundo.vim'                " Visualize undo tree

call vundle#end()                     " End Vundle. All Plugins must be added before this line.
filetype plugin indent on

"
" End Vundle configuration
"

"
" Vim configuration
"
set encoding=utf8                     " Set Vim's encoding to UTF-8
set mouse=a                           " Enable mouse in console
set number                            " Show line numbers
set wrap                              " Wrap lines
set linebreak                         " Break lines at word
set showbreak=+++                     " Prefix for broken lines  
set showmatch                         " Show matching parenthesis
set smartcase                         " Ignore case if search pattern is all lowercase
set hlsearch                          " Highlight search terms
set incsearch                         " Show search matches while typing
set laststatus=2                      " Always show the status line
set autoindent                        " Auto-indent new lines
set softtabstop=4                     " Each indentation level is 4 spaces
set shiftwidth=4                      " 4 spaces for indentation with reindent operations and automatic indentation
set expandtab                         " Tab will produce the appropriate number of spaces
set visualbell                        " Use visual bell (no beeping)
set undolevels=1000

if &t_Co > 2 || has("gui_running")
    " Enable syntax highlighting if terminal has colors or gui is running
    :syntax on
endif

if &t_Co >= 256 || has("gui_running")
    " Enable colorsheme if terminal has minimum of 256 colors or gui is running
    colorscheme kalisi
    set background=light
endif


"
" Key remapping
"
" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP 


"
" Syntastic configuration
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 
