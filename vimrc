" $Id: vimrc 54 2013-04-07 01:27:49Z jmosco $
"
" I have gone over to the dark side.  
"
" TODO
" - fix color scheme [DONE 1/5/12]
" - create own color scheme
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
" - Use powerline

" Global Settings
set encoding=utf-8
set number
set noshowmode			" No need since we are using powerline
set nocompatible                " always Vim mode
set ls=2
"set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
set hlsearch
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
filetype on
"filetype indent on
filetype plugin indent on

" Set the size of the window
" Not sure if this can detech which monitor we are on
" - if using desktop, increase font size
if has("gui_running")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
	set guifont=Monaco\ For\ Powerline:h14		
	set lines=30
	set columns=110
	endif
endif

" Pathogen
call pathogen#infect()

" Solarized theme
syntax enable
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Powerline settings
" This will need a writeup since it is a massive pain in the ass
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_colorscheme = 'solarized256'
"let g:Powerline_theme = 'solarized'
"let g:powerline_theme_overrides__{solarized}
let g:Powerline_symbols = 'fancy'
"let g:Powerline_symbols = 'unicode'
let g:Powerline_stl_path_style = 'full'
"let g:powerline_theme_overrides = {"default":{ "solarized" }}

" NERDtree
let g:NERDTreeWinPos = "right"

" Create backups.  This was learned the hard way.
set backup
set backupdir=~/.backups/
set backupext=.bak              "Append .bak to backup files
set writebackup

" Open where we last edited
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" | 
\ endif | endif

" Tips from Damian Conway for formatting
" from Perl Best Practices, and the Perl Monks
" color complex things
let perl_extended_vars = 1
let perl_include_pod = 1
"set textwidth=80

" Puppet Mode
"au BufRead,BufNewFile *.pp              set filetype=puppet

" Python tabs
autocmd FileType python setl shiftwidth=4 tabstop=4

" Make Backspaces delete sensibly
set backspace=indent,eol,start

" Tabs
set tabstop=8
"set expandtab
set shiftwidth=8

" Tabs for Puppet for following style guide
"autocmd FileType puppet setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType ruby setl tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Allow % to bounce between angles too
set matchpairs+=<:>

" Perldoc Plugin
"autocmd BufNewFile,BufRead *.p? map <F1> :Perldoc<cword><CR>
"autocmd BufNewFile,BufRead *.p? setf perl
"autocmd BufNewFile,BufRead *.p? let g:perldoc_program='/usr/bin/perldoc'
"autocmd BufNewFile,BufRead *.p? source ~/.vim/ftplugin/perl_doc.vim

" This should not be a replacement for a properly configured 
" TERM type.
"if $TERM =~ "xterm"
"        set t_Co=256    " Enable colors (256 for my color scheme)
"        set t_Sb=m      " bg color escape seq
"        set t_Sf=m      " fg color escape seq
"endif

"hi LineNr ctermbg=235           " Color around line numbers

" This is no longer needed because of iTerm and MacVim
" OS X paste hack
" y to copy to buffer.  p to paste from pasteboard
"if system('uname') =~ 'Darwin'
"        nmap y :.w !pbcopy<CR><CR>      
"        nmap p :r !pbpaste<CR>:set nopaste<CR> 
"endif

" set clipboard=unnamed

" CFEngine syntax highlighting
autocmd BufRead,BufNewFile *.cf set ft=cf3

" Unset the last search pattern by hitting return
nnoremap <CR>   :noh<CR><CR>

" End of Line niceness
"set list
"set listchars=tab:▸\,eol:¬

" Undo path
nnoremap <F5> :GundoToggle<CR>

" NERDtree options
map <C-n> :NERDTreeToggle<CR>

" Close Vim if the only window left is the NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Teach Vim to syntax highlight Vagrantfiles properly.
augroup vagrant
au!
	au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

" Custom bindings
" mostly stollen from the Internets
map <C-K> :bprev<CR>	" previous buffer
map <C-J> :bnext<CR>	" next buffer
