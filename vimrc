" -----------------------------------------------------------------------------
" TODO
" -----------------------------------------------------------------------------

" - fix color scheme [DONE 1/5/12]
"   NOTE: Switched to Solarized
" - Better Perl support
" - SVN [DONE 1/3/12]
" - comment everything!
" - move comments to the right
" - screen color support [DONE 1/30/12]
" - copy/paste for Mac OS X [DONE 1/7/12]
"   MacVim handles this perfectly
" - Fix indenting for Python [DONE 1/8/12]
" - Fix indenting
" - Fix indenting for Puppet [DONE 2/21/2013]
" - Better keybindings
" - Remove old junk!
" - Use powerline [DONE 7/30/13]
" - Use Softabs [DONE 8/2/13]

" -----------------------------------------------------------------------------
" Global Settings
" -----------------------------------------------------------------------------

" Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'Gundo'
Plugin 'majutsushi/tagbar'
Plugin 'ConradIrwin/vim-bracketed-paste'

if v:version >= 703 && has("patch584")
  Plugin 'Valloric/YouCompleteMe'
endif

call vundle#end()
filetype plugin indent on

set nocompatible                " always Vim mode
scriptencoding utf-8
set encoding=utf-8
set number                      " line numbers
set ls=2                        " show the status line
set hlsearch                    " search highlighting
set incsearch                   " search as you type
set ruler                       " show the cursor position
set vb t_vb=                    " go away BELLS
set noerrorbells                " Please be quiet
set sc                          " show current command
set directory=~/.backups/       " swap file location
set redraw optimize             " Keep the screen tidy
set history=10000               " history lines
set title                       " Inherit the term title from Vim
set titleold=""                 " No "Thanks for Flying Vim" message
set clipboard=unnamed
set linebreak
set hidden
set autoindent
set nosi                        " Disable 'smart'-indenting
set cursorline                  " Highlight the entire line the cursor is on
set noshowmode                  " No need since we are using powerline
"set tw=80
" Create backups.  This was learned the hard way.
set backup
set backupdir=~/.backups/
set backupext=.bak              "Append .bak to backup files
set writebackup
set backspace=indent,eol,start  " Make Backspaces delete sensibly
set smartcase                   " "Smart" searching
set ignorecase                  " Ignore case when searching


" Set the size of the window
" - if using desktop, increase font size
if has("gui_running")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    "set guifont=Monaco\ For\ Powerline:h14
    set guifont=Inconsolata-Dz\ For\ Powerline:h16
    set lines=30
    set columns=110
  endif
endif

" Solarized theme
syntax enable
set background=dark
colorscheme solarized
let g:solarized_diffmode="high"

" Airline settings
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
set fillchars+=stl:\ ,stlnc:\
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_show = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#tab_nr_type = 0 " tab number
let g:airline#extensions#tmuxline#enabled = 0

" NERDtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='\r'
let NERDChristmasTree=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
"let NERDTreeWinPos = "right"
map <Leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ------------------------------------------------------------------------------
" Misc formatting
" ------------------------------------------------------------------------------

" Open where we last edited
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \ exe "normal g'\"" |
      \ endif | endif

" Python tabs
autocmd FileType python setl shiftwidth=4 tabstop=4

" Tabs
" soft tabs, or tabs made up of space characters
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Ruby
autocmd FileType ruby setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" JSON
autocmd BufNewFile,BufRead *.json set ft=javascript

" Allow % to bounce between angles too
set matchpairs+=<:>

" End of Line niceness
set list
set listchars=tab:▸\ ,trail:☠

" Turn off the annoying auto comment feature
autocmd FileType * setlocal formatoptions-=ro

" ctags path
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" ------------------------------------------------------------------------------
" Custom Mappings
" ------------------------------------------------------------------------------

" Unset the last search pattern by hitting return
nnoremap <CR>   :noh<CR><CR>

" Undo path
nnoremap <F5> :GundoToggle<CR>

" Toggle Tagbar
nmap <F6> :TagbarToggle<CR>

" Switch Tabs
"map <C-K> gt
"map <C-J> gT

map <C-J> :bprev<CR>  " previous buffer
map <C-K> :bnext<CR>  " next buffer

" mute highlighting
nnoremap <silent> <c-l> :<c-u>nohlsearch<cr><c-l>

" Easy Expansion of the Active File Directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enable profiling
"nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
"nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

" Puppet lint arguments
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check --no-documentation-check --no-autoloader_layout-check'

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:tmuxline_preset = {
      \'a'    : '❐ #S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : '%R',
      \'y'    : ['%a', '%Y'],
      \'z'    : '#H'}

let g:tmuxline_theme = 'powerline'

" Switch back to blue
function! AirlineThemePatch(palette)
  let a:palette.normal.airline_a = [ '#ffffff', '#268bd2', 255, 33 ]
endfunction
let g:airline_theme_patch_func = 'AirlineThemePatch'

autocmd BufRead,BufNewFile *
      \  if expand('%:p:h') =~# '.*/cookbooks/.*'
      \|   setlocal makeprg=foodcritic\ $*\ %
      \|   setlocal errorformat=%m:\ %f:%l
      \| endif

" JSON
au BufRead,BufNewFile *.json set filetype=json

" Puppet ctags
let g:tagbar_type_puppet = {
  \ 'ctagstype': 'puppet',
  \ 'kinds': [
    \'c:class',
    \'s:site',
    \'n:node',
    \'d:definition',
    \'r:resource',
    \'f:default'
  \]
\}

" Go ctags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
