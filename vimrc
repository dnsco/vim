" 
"  DennisCollective's vimrc
"  its what gets me through.
"
" to get it to work 
" $ ln -s vimrc ~/.vimrc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					Load pathogen bundles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Order of this incantation is magic, and necessary on debian based distros
" http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html 
"
 filetype off   
 call pathogen#helptags()
 call pathogen#runtime_append_all_bundles()

 syntax on
 filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					Obvious Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible 			" 'cause this is vim, not vi 
set encoding=utf-8
set termencoding=latin1
set fileformat=unix
set history=50			" keep 50 lines of command line history

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					Fun Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden 	"you can change buffers without saving, beware when qa! or wqa 'ing !!!!!
"set completefunc " complete functions on C-x C-u    - this is crazy
set ruler		" show the cursor position all the time

set number	" show line numbers
set showmatch     " after typing a bracket, briefly show the matching bracket

set hlsearch	" highlight the search
set incsearch		" do incremental searching - search as word is typed

set showmode      " show the current Vim mode
set showcmd		" display incomplete commands
set wildmenu		" wildmenu surfing
set laststatus=2  " always show the status line

let g:ackprg="ack-grep -H --nocolor --nogroup --column"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					 Ruby Color Schemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

set background=dark

colorscheme vividchalk
"colorscheme aiseered
"colorscheme codeburn
"colorscheme dark-ruby
"colorscheme earthburn
"colorscheme fruity
"colorscheme herald
"colorscheme ir_black
"colorscheme jellybeans
"colorscheme lettuce
"colorscheme moria
"colorscheme norwaytoday
"colorscheme seoul


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					 Text Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

syntax enable " enable syntax highlighting

filetype plugin indent on

set backspace=indent,eol,start 	" backspace over everything in insert mode
set ts=2 		" tabs are 2 spaces
set shiftwidth=2	"smart indent

augroup vimrcEx 										" Basic settings for stuff
	" delete all autocommands - I think
	au!				
	au! BufRead,BufNewFile *.json setfiletype json 
	autocmd FileType text setlocal textwidth=78			" set width 78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.

	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif

	"autoindent with two spaces, always expand tabs
	autocmd BufNewFile,BufRead *.ru setfiletype ruby
	autocmd FileType ruby,haml,eruby,yaml set ai sw=2 sts=2 et
  au BufNewFile,BufRead *.svg setf svg 
	autocmd BufRead,BufNewFile Gemfile set filetype=Gemfile 

augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					Loopy Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"					Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

autocmd BufWritePre *.rb :call <SID>StripTrailingWhitespaces()

" evaluate ruby scripts with F7 - open vertical window for output
" use shift F7 to close

function! Ruby_eval_vsplit() range
 let src = tempname()
 let dst = tempname()
 execute ": " . a:firstline . "," . a:lastline . "w " . src
 execute ":silent ! ruby " . src . " > " . dst . " 2>&1 "
 execute ":redraw!"
 execute ":vsplit"
 execute "normal \<C-W>l"
 execute ":e! " . dst
 "  execute "normal \<C-W>h"
endfunction
let g:rubycomplete_rails = 1

vmap <silent> <F7> :call Ruby_eval_vsplit()<cr>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <ESC><F7>a
map <silent> <S-F7> <C-W>l:bw<cr>
imap <silent> <S-F7> <ESC><S-F7>



" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"			Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:speckyBannerKey = "<leader>b"
let g:speckyQuoteSwitcherKey = "<leader>'"
let g:speckyRunRdocKey = "<leader>r"
let g:speckySpecSwitcherKey = "<leader>x"
let g:speckyRunSpecKey = '<leader>s'
let g:speckyRunSpecCmd = "spec -fs"
let g:speckyRunRdocCmd = "fri -L -f plain"
let g:speckyWindowType = 2


nmap ;f :CommandT<cr>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 


"let loaded_project = 1  		"disables Project plugin


" key-mappings for comment line in normal mode
noremap  <silent> <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <leader>u :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <leader>u :call RangeUnCommentLine()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
map Q gq				" use Q for formatting

map <S-Insert> <MiddleMouse>			" Make shift-insert work like in Xterm
map! <S-Insert> <MiddleMouse>

map 'v :sp $HOME/.vimrc<CR><C-W>_    " ,v brings up ~/.vimrc
",V reloads it -- making all changes active (have to save first)
map <silent> 'V :source $HOME/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>			" \d for NERDtree

se backupdir=/var/tmp
se dir=/tmp
