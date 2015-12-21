""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
"    Ben Weeks's Dotfiles: .vimrc                                              "
"    - uses NeoBundle to manage and load plugins                               "
"                                                                              "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Pre-setup

if has('vim_starting')
    set nocompatible                                    " Be iMproved
    set runtimepath+=~/.vim/bundle/neobundle.vim/       " NeoBundle, required
endif

call neobundle#rc(expand('~/.vim/bundle/'))             " NeoBundle, required
NeoBundleFetch 'Shougo/neobundle.vim'                   " NeoBundle, required

filetype plugin indent on                               " NeoBundle, required
NeoBundleCheck    

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> General
syntax on                                               " Use syntax highlighting
set history=1000                                        " minimum history recording
set title                                               " vim sets terminal title
set tabpagemax=50                                       " `vim -p file file file` ...
set encoding=utf-8                                      " Unicode by default
set dictionary=/usr/share/dict/words                    " i ctrl_x ctrl_k completion

set undofile                                            " save central undo files
set undodir=~/.vim/tmp/undo/
set backup                                              " enable backups
set backupdir=~/.vim/tmp/backup/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Behaviors

set gdefault                                            " s/foo/bar/ => s/foo/bar/g

set backspace=indent,eol,start                          " erase autoindents, join lines
set wildmenu                                            " vim internal tab-completion
set wildmode=list:longest

                                                        " Search behavior
set ignorecase                                          " ingnore UPPPER/lower case
set smartcase                                           " insensitive until you are
set incsearch                                           " search as characters are entered
set hlsearch                                            " highlight matches

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Visual Behaviors
set number                                              " Line # by default
set showcmd                                             " show command in status line

set lazyredraw                                          " redraw a/ macros or registers
set visualbell                                          " Flash screen not bell
set showmatch                                           " flash to the matching paren
set matchtime=2                                         " for 2 seconds (default 5)
set wrap                                                " Wrap long lines
set textwidth=80                                        " consider PEP8 by default
set scrolloff=2                                         " keep 2 lines between cursor and edge
set formatoptions=qn2                                   " Format comments gq
                                                        "   reconize numbered lists
                                                        "   No break lines after 1 letter word
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h11       " Make sure gVim uses a powerline font

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Tab behaviors
set tabstop=4                                           " 4 space tabs
set softtabstop=4
set shiftwidth=4
set expandtab                                           " turn tabs to spaces
set smarttab                                            " remember indent
set autoindent                                          " smart auto indenting

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Split behaviors
set splitbelow                                          " new hoz splits go below
set splitright                                          " new vert splits go right

NeoBundle 'christoomey/vim-tmux-navigator'
                                                " Switch panes with ctrl + hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Style

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'        " Highlight merge conflicts
set list listchars=tab:·\ ,trail:≁,nbsp:∝               " Highlight special characters
set showbreak=↪                                         " Mark lines that have been wrapped
" cpotions: aABceFs -- defaults
set cpo+=J                                              " Yank by sentence (2-space a/ period)

NeoBundle 'sjl/badwolf'
NeoBundle 'altercation/vim-colors-solarized'
" TODO This looks bad! Fixit.
if has('gui_running')
    colorscheme solarized
    set background=light
else
    colorscheme badwolf
    set background=dark
endif

set fillchars=vert:│

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Leader key bindings     TODO: Change this!
let mapleader = " "                                     " <space> as leader ++
                                        " Strip whitespaces
"nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
                                        " select last selected or pasted thing
"nnoremap <leader>v V`]
                                        " edit vimrc in vert split
"nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr> "open vimrc for editing
                                        " set filetype to htmldjango
nnoremap <leader>h :setfiletype htmldjango<cr>
                                        " use 2-tab spaces
"nnoremap <leader>2 :call TStwo()<CR>
                                        " use 4-tab spaces
"nnoremap <leader>4 :call TSfour()<CR>
                                        " toggle set paste
"nnoremap <leader>p :set paste!<CR>
                                        " new hoz split
nnoremap <leader>w <C-w>v
                                        " new vert split
nnoremap <leader>- <C-w>s

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Tagbar tag browser
NeoBundleLazy 'majutsushi/tagbar',      {'autoload' : {'filetypes' : ['python', 'ruby', 'javascript', 'css'] } }
NeoBundleLazy 'vim-scripts/AutoTag',    {'autoload' : {'filetypes' : ['python', 'ruby', 'javascript', 'css'] } }
                                        " open tagbar, switch to it
nnoremap <leader>t :TagbarToggle<CR>
                                        " open tagbar, close when done
nnoremap <leader>T :TagbarOpenAutoClose<CR>

if (exists(":TagbarToggle"))
    " if tagbar is loaded
    " enable tagbar etension for airline
    let g:airline#extensions#tabline#enabled = 1
en

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> vimproc - execute shell in VIM
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Git statuses
NeoBundle 'tpope/vim-fugitive'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Functions
function! TStwo()
    setlocal tabstop=2 softtabstop=2 shiftwidth=2
endfunction

function! TSfour()
    setlocal tabstop=4 softtabstop=4 shiftwidth=4
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Syntastic error highlighting
NeoBundleLazy 'scrooloose/syntastic', {'autoload' : {'filetypes' : ['ruby', 'javascript'] } }
                                        " Show syntastic error box
nnoremap <leader>e :lw<CR>
                                        " Hide syntastic error box
nnoremap <leader>E :lcl<CR>
let g:syntastic_check_on_open=1         " Don't check for errors until save
"let g:syntastic_enable_signs=0         "no left of linenum signs
let g:syntastic_error_symbol=' ⧰'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_jump=0 " Do not jump to first error on save/open
let g:syntastic_stl_format = '[%E{⧰: #%e l%fe}%B{, }%W{⚠: #%w %fw}]'
let g:syntastic_python_checker_args='-d C0301,E1101'
                            " E501 line too long
                            " E221 too much space before = (aligning ='s)
                            " E126 too many tabs after a continuation `\`

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Indentation gutters for HTML
NeoBundleLazy 'nathanaelkane/vim-indent-guides', {'autoload' : {'filetypes' : ['html'] } }
let g:indent_guides_start_level = 2                     " Show vert gutters in html files


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Airline
NeoBundle 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
" when only one tab is open, show all of the open buffers
" user powerline patched fonts = no
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
" dict of configurably unicode symbols. mmmmmmmmmm
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Python
"NeoBundleLazy 'ehamberg/vim-cute-python', {'autoload' : {'filetypes' : ['python'] } }
NeoBundleLazy 'klen/python-mode', {'autoload' : {'filetypes' : ['python'] } }
NeoBundle 'nvie/vim-flake8'

" Configuration for Python-mode
let g:pymode_quickfix_minheight = 5
let g:pymode_quickfix_maxheight = 12
let g:pymode_folding = 0
let g:pymode_breakpoint_bind = '<leader>b'
"let g:pymode_breakpoint_cmd = '' " blank for auto detect?
nnoremap <leader>l :PymodeLint<cr>
let g:pymode_lint_ignore = "E501,E221"
" error signs
let g:pymode_lint_todo_symbol = '⚔'
"let g:pymode_lint_error_symbol = '⚠'
let g:pymode_lint_error_symbol = '‼‼'
let g:pymode_lint_comment_symbol = '♲'
let g:pymode_rope_show_doc_bind = '<leader>d'
let g:pymode_rope_goto_definition_bind = '<leader>g'
"let g:pymode_rope_organize_imports_bind = '<C-c>ro' "default

" Movement
" [[,]] prev|next class/func
" [M,]M prv|next class/method
" aC Select a class. Ex: vaC, daC, yaC, caC
" iC Select inner class. Ex: viC, diC, yiC, ciC
" aM Select a function or method. Ex: vaM, daM, yaM, caM
" iM Select inner function or method. Ex: viM, diM, yiM, ciM

" TODO let g:pymode_virtualenv_path = $VIRTUAL_ENV


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> Syntax bundles
" Handle new html5 tags and properties
NeoBundleLazy 'othree/html5.vim.git', {'autoload' : {'filetypes' : ['html'] } }
" Add CSS3 syntax highlighting
NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload' : {'filetypes' : ['css'] } }
" Highlight scss
NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload' : {'filetypes' : ['scss'] } }
" leader V toggles
NeoBundleLazy 'mikewest/vimroom', {'autoload' : {'filetypes' : ['markdown'] } }
" ReStructured Text (.rst files)
NeoBundle 'Rykka/riv.vim'

" ~> Nerd commenter
NeoBundle 'scrooloose/nerdcommenter'
" ~> Surround
NeoBundle 'tpope/vim-surround'

" ~> Auto-Close
NeoBundle 'spf13/vim-autoclose'

" ~> Emmet
NeoBundle 'mattn/emmet-vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> NYAN ME
function! NyanMe() " {{{
    hi NyanFur             guifg=#BBBBBB
    hi NyanPoptartEdge     guifg=#ffd0ac
    hi NyanPoptartFrosting guifg=#fd3699 guibg=#fe98ff
    hi NyanRainbow1        guifg=#6831f8
    hi NyanRainbow2        guifg=#0099fc
    hi NyanRainbow3        guifg=#3cfa04
    hi NyanRainbow4        guifg=#fdfe00
    hi NyanRainbow5        guifg=#fc9d00
    hi NyanRainbow6        guifg=#fe0000


    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl None
    echo ""

    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl NyanFur
    echon "╰"
    echohl NyanPoptartEdge
    echon "⟨"
    echohl NyanPoptartFrosting
    echon "⣮⣯⡿"
    echohl NyanPoptartEdge
    echon "⟩"
    echohl NyanFur
    echon "⩾^ω^⩽"
    echohl None
    echo ""

    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl NyanRainbow1
    echon "≈"
    echohl NyanRainbow2
    echon "≋"
    echohl NyanRainbow3
    echon "≈"
    echohl NyanRainbow4
    echon "≋"
    echohl NyanRainbow5
    echon "≈"
    echohl NyanRainbow6
    echon "≋"
    echohl None
    echon " "
    echohl NyanFur
    echon "”   ‟"
    echohl None

    sleep 1
    redraw
    echo " "
    echo " "
    echo "Noms?"
    redraw
endfunction " }}}
command! NyanMe call NyanMe()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ~> End of configuration
