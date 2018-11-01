"----------GENERAL SETTINGS----------
" By Darko Tasevski
" Non-compatible vi mode. Remove annoying vi consistency mode, to avoid some of the bugs and limitations of the previous version
set nocompatible                    " Disable vi-compatibility.
filetype on                         " Detect the type of file
syntax on                           " Turn syntax highlighting

" Encoding, du-uh.
set encoding=utf-8                  " Set the encoding of the new file to UTF - 8
set fileencoding=utf-8
set ffs=unix,dos,mac                " Use Unix as the standard file type

" Editor settings.
set number                          " Display line numbers.

" Display hidden symbols
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Autoremove trailing whitespaces before :w
autocmd BufWritePre * %s/\s\+$//e

" Syntax highlighting.
if !exists("g:syntax_on")
    syntax enable
endif

" Text indentation settings.i
"
filetype  on                        " test file type
filetype  indent  on                " uses different indentation for different file types
filetype  plugin  on                " allows plugins
filetype  plugin indent on          " start automatically completed
set tabstop=4                       " Show existing tab with 4 spaces width.
set shiftwidth=4                    " When indenting with '>', use 4 spaces width.
set expandtab                       " On pressing tab, insert 4 spaces.
set showmatch                       " Match parentheses/brackets.
set matchtime=3                  " Match brackets highlight the time (in tenths of a second)

" Achieve (, [, {,", 'Automatically fill in the right part of the input, the cursor will be in the middle position
inoremap (() <ESC> i
inoremap [] <ESC> i
inoremap {{} <ESC> i
inoremap < <><ESC>i
inoremap " ""<ESC>i
inoremap  '  ' ' <ESC> i

" Search settings.
set hlsearch                        " Highlight all search pattern matches.
set incsearch                       " Incremental search.
set ignorecase                      " Ignore case when searching.

                                    " Highlight current line and column of cursor.
set cursorline
set cursorcolumn
set ruler                          " shows the current line number column number

                                    " Open new split panes to right and bottom.
set splitbelow
set splitright

" Retracted configuration
set smartindent
set autoindent                     " to turn on automatic indentation

" After exiting vim, the content is displayed on the terminal screen and can be used for viewing and copying
" Benefits-> What is accidentally deleted, if the previous screen opens, you can retrieve
"
set  t_ti =  t_te =

" Set color and position of colorcolumn.
set colorcolumn=120
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Scrolling settings.
set scrolloff=10                    " Number of lines above and below the cursor.

" Disable temporary files.
set nobackup
set noswapfile
set nowritebackup

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" For regular expressions turn magic on
set magic

" If not exists - create folders for swap files.
" silent !mkdir -p ~/.vim/backup
" silent !mkdir -p ~/.vim/swap
" silent !mkdir -p ~/.vim/undo

" Swap files out of the project root.
" set backupdir=~/.vim/backup//
" set directory=~/.vim/swap//
" set undodir=~/.vim/undo//

" autocmd !  bufwritepost  ~ / .vimrc  source  % " vimrc file is automatically loaded after the change.

" JavaScript file, four spaces to indent
autocmd FileType javascript set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType coffee set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType json set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType html set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType jinja set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType css set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType yaml,jade set tabstop=4 shiftwidth=4 expandtab ai

" Makefile does not replace the tab with a space
autocmd FileType make set noexpandtab ai


" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Automatic completion of the configuration
" Let Vim's complement menu behave as a regular IDE (see VimTip 1228)
set completeopt=longest,menu

"----------PLUGINS-------------------

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

" Plugin manager auto install.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" UI.
Plug 'morhetz/gruvbox'                                              " Retro groove color scheme.
Plug 'dracula/vim'                                                  " A dark theme for Vim and 40+ apps
Plug 'vim-airline/vim-airline'                                      " Lean & mean status/tabline.
Plug 'mhinz/vim-startify', {'do': 'mkdir -p ~/.vim/files/info'}     " A start screen for Vim.


" Filetype angnostic plugins.
Plug 'tpope/vim-sensible'           " Defaults everyone can agree on.
Plug 'sheerun/vim-polyglot'         " A solid language pack.
Plug 'junegunn/vim-peekaboo'        " Show the contents of the registers.
Plug 'scrooloose/nerdtree'          " A tree explorer plugin for vim.
Plug 'jistr/vim-nerdtree-tabs'      " A plugin of NERDTree showing git status.
Plug 'jiangmiao/auto-pairs'         " Insert or delete brackets, parens, quotes in pair.
Plug 'kien/ctrlp.vim'               " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'tpope/vim-surround'           " Surround.vim is all about 'surroundings': parentheses, brackets, ..., etc.
Plug 'jlanzarotta/bufexplorer'      " Quickly and easily switch between buffers.
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } " Autocompletion for Vim
Plug 'nathanaelkane/vim-indent-guides' " Indent guides for Vim
Plug 'pangloss/vim-javascript'      " JavaScript bundle, provides syntax highlighting and improved indentation.
Plug 'scrooloose/syntastic'         " Syntax checking hacks for vim

" Git plugins.
Plug 'tpope/vim-fugitive'           " A git wrapper so awesome, it should be illegal.

call plug#end() " All Plugins must be added before this

"----------PLUGGINS SETTINGS---------
" Syntastics settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']

" Filter out some error messages
" Trimming empty warning labels, there is nothing in the instructions for some labels
let g:syntastic_html_tidy_ignore_errors = ['trimming']

" Plug 'scrooloose/nerdtree'.
" Open NERDTree with 'Ctrl+n'.
map <Leader>n :NERDTreeToggle<CR>
" Change default arrows.
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Enable indent  guides by default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2 " The second layer begins visual display indented
let g:indent_guides_guide_size=1  " Color block width
" Shortcut i on / off indent Visualization
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" Plug 'jistr/vim-nerdtree-tabs'.
" Open NERDTree with '<Leader>n'.
 map <C-n> <plug>NERDTreeTabsToggle<CR>

" Plug 'Xuyuanp/nerdtree-git-plugin'.
" Config custom symbols.
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Plug 'kien/ctrlp.vim'.
" Change the default mapping and the default command to invoke CtrlP.
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
" Exclude files and directories.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
" Use a custom file listing command.
let g:ctrlp_user_command = 'find %s -type f'

" Plug 'tpope/vim-fugitive'
" Git shortcuts.
map gw :w<CR>:Gwrite<CR>
map gc :w<CR>:Gcommit<CR>
map gp :w<CR>:Gpush<CR>
map gs :w<CR>:Gstatus<CR>

" Midnight Commander shortcut.
map mc :w<CR>:!mc<CR>

" Plug 'mhinz/vim-startify'
" :help startify-faq-02
set viminfo='100,n$HOME/.vim/files/info/viminfo

" Plug 'wakatime/vim-wakatime'
" Enables redrawing the screen after sending heartbeats.
let g:wakatime_ScreenRedraw = 1

" Plug 'jlanzarotta/bufexplorer'
nnoremap bv :BufExplorerVerticalSplit<CR>

"----------UI SETTINGS---------------

set t_Co=256                        " Enable 256 colors.
set background=dark                 " Editor background.

colorscheme dracula                 " Colorscheme settings.
" colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1

" colorscheme tomorrow
" colorscheme tomorrow-night
" colorscheme tomorrow-night-eighties
" colorscheme tomorrow-night-bright
let g:airline_theme='gruvbox'
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'

syntax enable
" colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif

" Consistency flag is set a background color and line color digital
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight, to prevent the wrong red line lead to the whole unclear
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

"----------KEYBINDINGS--------------

" Set leader key.
let mapleader=','

" Turn off Vim search highlighting
nnoremap <F3> :set hlsearch!<CR>

" Show relative line numbers.
nnoremap <leader>r :set relativenumber!<CR>

" Enable paste mode.
set pastetoggle=<F2>

" Toggle list (display unprintable characters).
nnoremap <F3> :set list!<CR>

" Hide search search highlight.
nnoremap <F5> :nohl<CR>

" Tabs management.
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap to :tabonly<CR>

" HTML folding.
nmap hf zfat

" Avoid the escape key in INSERT mode.
imap jj <Esc>:w<CR>

" No one is really happy until you have this shortcuts.
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q
cmap W! w !sudo tee % >/dev/null

" ;s for 'refactoring'
nnoremap ;s :%s/\<<C-r><C-w>\>/

" Move text blocks in visual mode.
vnoremap < <gv
vnoremap > >gv

" Navigation betwee splits.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Swap top/bottom or left/right split.
" Ctrl+W R
"
" Break out current window into a new tabview.
" Ctrl+W T
"
" Close every window in the current tabview but the current one.
" Ctrl+W

" Resize splitted windows.
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left>  :vertical resize -5<CR>
nnoremap <silent> <C-Up>    :resize -5<CR>
nnoremap <silent> <C-Down>  :resize +5<CR>

set wildmenu                        " Turn on wildmenu (command line completion suggestions)
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=.sass-cache                      " Sass
set wildignore+=*/tmp/*                          " Temporary files
set wildignore+=*/bin/*                          " Build artefacts
set wildignore+=*/gen/*                          " Build artefacts
set wildignore+=.vimtags                         " tags file
set wildignore+=*/log/*
set wildignore+=*/public/uploads/*
set wildignore+=*/bundle.js

