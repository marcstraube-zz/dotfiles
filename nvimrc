"
" Begin Vundle configuration
"
filetype off

set rtp+=~/.Vundle/Vundle.vim         " Set the runtime path to inclue Vundle
call vundle#begin("~/.Vundle")        " Init Vundle

Plugin 'VundleVim/Vundle.vim'         " Let Vundle manage Vundle

" List plugins managed by Vundle
Plugin 'qpkorr/vim-bufkill'           " Kill a buffer without closing a window or split
Plugin 'scrooloose/nerdtree'          " Filetree browser
Plugin 'scrooloose/nerdcommenter'     " Commenter
Plugin 'scrooloose/syntastic'         " Syntax checker
Plugin 'ivalkeen/nerdtree-execute'    " Execute files from within NERDTree
Plugin 'kien/ctrlp.vim'               " Fast file navigation
Plugin 'jlanzarotta/bufexplorer'      " Buffer explorer
Plugin 'tpope/vim-fugitive'           " Git repository management
Plugin 'tpope/vim-surround'           " Manipulate 'surroundings' (parentheses, brackets, ...)
Plugin 'tpope/vim-repeat'             " enable repeating supported plugin maps with '.'
Plugin 'Raimondi/delimitMate'         " Auto completion for quotes, parens, etc.
Plugin 'majutsushi/tagbar'            " Class browser
Plugin 'freeo/vim-kalisi'             " Colorscheme
Plugin 'MarcWeber/vim-addon-mw-utils' " Dependency for vim-snipmate
Plugin 'tomtom/tlib_vim'              " Dependency for vim-snipmate
Plugin 'garbas/vim-snipmate'          " Text and code templates
Plugin 'godlygeek/tabular'            " Text aligning
Plugin 'sjl/gundo.vim'                " Visualize undo tree
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}  " Write HTML code faster
Plugin 'lukaszb/vim-web-indent'       " Better indentation for JavaScript and HTML
Plugin 'marcstraube/fortunes.vim'     " Add a fortune on F5 
Plugin 'lervag/vimtex'                " Support for writing LaTeX documents
Plugin 'rking/ag.vim'                 " Source code search with ag
Plugin 'amiorin/vim-project'          " Project management

call vundle#end()                     " End Vundle. All Plugins must be added before this line.
filetype plugin indent on

"
" End Vundle configuration
"

"
" NeoVim configuration
"
set number                            " Show line numbers
set ruler                             " Show line an column number of the cursor position
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

if &t_Co > 2 || has("gui_running")
    " Enable syntax highlighting if terminal has colors or gui is running
    :syntax on
endif

if &t_Co >= 256 || has("gui_running")
    " Enable colorsheme if terminal has minimum of 256 colors or gui is running
    colorscheme kalisi
    set background=light
endif

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=7
endif

"
" Key remapping
"
tnoremap <Leader>e <C-\><C-n>         " Map Leader + e to exit terminal mode

" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP 

" Remap NeoVim Terminal keys
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_less_checkers = ['lessc']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_sass_checkers = ['sassc']
let g:syntastic_scss_checkers = ['sassc']
let g:syntastic_twig_checkers = ['twiglint']
let g:syntastic_xml_checkers = ['xmllint']

"
" Ag configuration
"
let g:agprg="<custom-ag-path-goes-here> --vimgrep"
let g:ag_working_path_mode="r"
