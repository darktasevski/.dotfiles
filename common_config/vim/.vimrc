"" Based on tips from  VIM Revisited (after dropping Janus)
"" http://mislav.uniqpath.com/2011/12/vim-revisited/

" Changelog
" @forked from 
" 2019-04-02 Swapped Vundle for vim-plug. Needed post-install hooks 
" 2015-09-24 Swapped Pathogen for Vundle. Simplicity!
"            Tipped from: http://lepture.com/en/2012/vundle-vs-pathogen

" Resets all auto commands before adding them - important when sourcing twice
autocmd! 

set nocompatible               " be iMproved
set modeline
set modelines=5                " The number of lines to search for a modeline, must be non-0
filetype off                   " required!


" Automatically do :ALEFix
" http://liuchengxu.org/posts/use-vim-as-a-python-ide/
let g:ale_fix_on_save = 1
" Enable completion where available.
" " This setting must be set BEFORE ALE is loaded.
" let g:ale_completion_enabled = 1
nmap <F8> <Plug>(ale_fix)

source ~/.vim/plugins-config

filetype plugin indent on       " load file type plugins + indentation
" To ignore plugin indent changes, instead use:
"filetype plugin on

syntax enable
set encoding=utf-8

"" GUI
" This is a default scheme that works well
" Override in ~/vimrc.local
colorscheme darkblue
set guifont=PragmataPro:h14

"" check out http://superuser.com/questions/693528/vim-is-there-a-downside-to-using-space-as-your-leader-key
:let mapleader="," 
"" Don't rely on Cmd working in vim. Learn to use <leader>c<space>
"" http://stackoverflow.com/questions/9450905/how-to-bind-vim-through-tmux-to-cmd-key/9451636#9451636
"" map <D-/> <plug>NERDCommenterToggle  
set showcmd "" show leader commands
set ruler						" shows the current line number column number

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is four spaces 
set expandtab                   " use spaces, not tabs (optional).  On pressing tab, insert 4 spaces.
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set printoptions=portrait:n

"" Pasting text - toggle between paste and insert mode using F2
"" http://nvie.com/posts/how-i-boosted-my-vim/
set pastetoggle=<F2>


" Remember last position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"" File type settings
"" Set filetype text if unset
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

" text files
autocmd Filetype text set wrap | set linebreak
autocmd Filetype markdown set wrap | set linebreak

" associate *.vss (VectorScript) with Pascal filetype
au BufRead,BufNewFile *.vss set filetype=pascal
" associate Processing files with Java
au BufRead,BufNewFile *.pde set filetype=java
" associate *.ts with TypeScript
au BufRead,BufNewFile *.ts set filetype=typescript
" associate *.kit with Html
au BufRead,BufNewFile *.kit set filetype=html

" Use nginx syntax highlighting
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx


" Auto-reload vimrc on changes
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %
autocmd! bufwritepost plugins-config source %
autocmd! bufwritepost coc-config source %

" Make vim work as a crontab editor: http://vim.wikia.com/wiki/Editing_crontab
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Make NERDTree open automatically if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Make the local current directory reflect the currently open buffer
" Disabled on 2019-04-03: Breaks fugitive.vim :(
" autocmd BufEnter * lcd %:p:h

" Silence NerdTree errors - might have been introduced by the above
" https://github.com/scrooloose/nerdtree/issues/162#issuecomment-107643011
" nmap <silent> <Leader>t :call g:WorkaroundNERDTreeToggle()<CR>

" function! g:WorkaroundNERDTreeToggle()
   "try | NERDTreeToggle | catch | silent! NERDTree | endtry
" endfunction

" Open/Close NerdTree with Ctrl-N, but only in Normal mode
nmap <C-n> :NERDTreeToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
" https://stackoverflow.com/a/7078429/200987
cmap w!! w !sudo tee > /dev/null %

" Tips mostly from nvie.com/
set showmatch     " When in insert mode, this will momentarily flash the cursor back to the opening bracket
set matchtime=1   " just jump for 100 ms

set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
" Clear highlighted search text by just typing ",/"
nmap <silent> <leader>/ :nohlsearch<CR>  
" Use sudo after you opened a file, in case you forgot
cmap w!! w !sudo tee % >/dev/null

" Show 'hidden' characters, like tab and newline: https://vi.stackexchange.com/a/430/1087
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" Lucas F. Costa: http://lucasfcosta.com/2017/01/23/Quick-vIM-Tips-That-Will-Save-Your-Life.html
set relativenumber             " Show relative line numbers
set number                     " Show current line number
" https://twitter.com/mantoni/status/880079687946522625
set suffixesadd+=.js           " Makes gf work for relative files as well

" Disable mouse integration by default to make copy-paste easy. Toggle with F12
set mouse=

" These needs to be before later configuration for objects to be defined
source ~/.vim/ctrlp-config
source ~/.vim/coc-config

" Elm settings - see https://github.com/elmcast/elm-vim
let g:elm_format_autosave = 1 "reformat on autosave
"let g:ycm_semantic_triggers.elm = ['.']

" js settings
let g:javascript_plugin_jsdoc = 1
" enable auto sort import on write
" see https://github.com/ruanyl/vim-sort-imports#available-cmd
let g:import_sort_auto = 1
" temporary fix for JSX: https://github.com/pangloss/vim-javascript/issues/955#issuecomment-356350901
let g:jsx_ext_required = 0
" auto-format
" Disable using :RepoVimrcEdit and 'autocmd!'
" autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.jsx Neoformat

" Understand JSONC (json with comments)
autocmd FileType json syntax match Comment +\/\/.\+$+


" Set up neomake as well: It is intended to replace the built-in :make command and provides functionality similar to plugins like syntastic and dispatch.vim. It is primarily used to run code linters and compilers from within Vim, but can be used to run any program.

" Set up fzf instead of Ctrl-P
" fzf and fzf.vim

let g:ale_fixers = {
\   'javascript': [
\       'eslint --fix',
\       'eslint',
\       {buffer, lines -> filter(lines, 'v:val !=~ ''^\s*//''')},
\   ],
\}

""" More Customizations """

" Achieve (, [, {,", 'Automatically fill in the right part of the input, the cursor will be in the middle position
inoremap (() <ESC> i
inoremap [] <ESC> i
inoremap {{} <ESC> i
inoremap < <><ESC>i
inoremap " ""<ESC>i
inoremap  '  ' ' <ESC> i

" After exiting vim, the content is displayed on the terminal screen and can be used for viewing and copying
" Benefits-> What is accidentally deleted, if the previous screen opens, you can retrieve
"
set  t_ti =  t_te =

" For regular expressions turn magic on
set magic

" Automatic completion of the configuration
" Let Vim's complement menu behave as a regular IDE (see VimTip 1228)
set completeopt=longest,menu

"----------UI SETTINGS---------------
set t_Co=256                        " Enable 256 colors.
set background=dark                 " Editor background.
colorscheme solarized               " Colorscheme settings.

let g:airline_theme='gruvbox'
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'

source ~/.vimrc.local

" vi: ft=vim
