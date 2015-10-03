"
" Vim-Plug configuration
"

call plug#begin("~/.VimPlug")         " Init Vim-Plug

" List plugins managed by Vim-Plug
Plug 'qpkorr/vim-bufkill'             " Kill a buffer without closing a window or split
Plug 'scrooloose/nerdtree'            " Filetree browser
Plug 'scrooloose/nerdcommenter'       " Commenter
Plug 'scrooloose/syntastic'           " Syntax checker
Plug 'ivalkeen/nerdtree-execute'      " Execute files from within NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'    " Let NERDTree show git status flags
Plug 'kien/ctrlp.vim'                 " Fast file navigation
Plug 'jlanzarotta/bufexplorer'        " Buffer explorer
Plug 'tpope/vim-fugitive'             " Git repository management
Plug 'tpope/vim-surround'             " Manipulate 'surroundings' (parentheses, brackets, ...)
Plug 'tpope/vim-repeat'               " enable repeating supported plugin maps with '.'
Plug 'Raimondi/delimitMate'           " Auto completion for quotes, parens, etc.
Plug 'majutsushi/tagbar'              " Class browser
" Text and code templates
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate' | Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'              " Text aligning
Plug 'sjl/gundo.vim'                  " Visualize undo tree
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}  " Write HTML code faster
Plug 'lukaszb/vim-web-indent'         " Better indentation for JavaScript and HTML
Plug 'marcstraube/fortunes.vim'       " Add a fortune on F5 
Plug 'lervag/vimtex'                  " Support for writing LaTeX documents
Plug 'mileszs/ack.vim'                " Source code search with ack & ag
Plug 'rking/ag.vim'                   " Source code search with ag
Plug 'amiorin/vim-project'            " Project management
Plug 'bling/vim-airline'              " Lean & mean status/tabline

" Colorschemes
Plug 'freeo/vim-kalisi'
Plug 'cschlueter/vim-wombat'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'daddye/soda.vim'

call plug#end()                       " End Vim-Plug. All Plugins must be added before this line.


"
" Project settings
"
let g:project_use_nerdtree = 1
set rtp+=~~/.VimPlug/vim-project/
call project#rc("~/Code")

Project 'dotfiles'


"
" NeoVim configuration
"
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
" Ignore the listed filetypes in the wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.tmp,*.zip
filetype plugin indent on

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

" Unmap the arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP 

" Fast window moves in normal mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remap NeoVim Terminal keys
tnoremap <Leader>e <C-\><C-n>         " Map Leader + e to exit terminal mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Gundo
nnoremap <F7> :GundoToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>


"
" Plugin settings
"

" Airline
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1"


" Syntastic configuration
"
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


" Ack & Ag configuration
"
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

let g:ag_working_path_mode="r"


" Colorscheme settings
"
let g:solarized_termcolors=256


" NERDTree
"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '◄'


" NERDTree Git
"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "●",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "→",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "X",
    \ "Clean"     : "√",
    \ "Unknown"   : "?"
\ }


" CtrlP
"
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': '',
    \ }
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }

