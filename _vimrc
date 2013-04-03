" Use all the bells and whistles of Vim compared to vi
set nocompatible

" Turns on syntax highlighting 
syntax on 

" Set the syntax color scheme 
colors elflord

" Optimize the colors to a dark background
set background=dark

" Highlight searches 
set hlsearch

" While typing a search command, show where the pattern, as it was typed so
" far matches.  
set incsearch

" If a search only contains small chars it Vim ignores cases and if the
" search contains large chars Vim will search for the case-sensitive string
set smartcase

" When a bracket is inserted, briefly jump to the matching one. 
set showmatch

" Show the line and column number of the cursor position
set ruler
set nu

" Use vertical splited window (instead of horizontal) to show help message
command -nargs=* -complete=help H vertical belowright help <args>

set shell=/bin/bash\ -l

"Set terminal title to Vim + filename
set title

" Show (partial) command in the last line of the screen.
set showcmd

" Set history 
set history=99999

" Persist undo
set undodir=$HOME/Dropbox/dotfiles/.tmp/.vim//,.
set undofile
"maximum number of changes that can be undone
set undolevels=9999 
"maximum number lines to save for undo on a buffer reload
set undoreload=9999 

" Set to auto read when a file is changed from the outside
set autoread

" Try to store all swp files in Dropbox
set dir=$HOME/Dropbox/.tmp/.vim//,.

" No annoying blinking or noise
set novisualbell 
set noerrorbells 

" Indicates a fast terminal connection.
set ttyfast

" show some autocomplete options in status bar
set wildmenu

" Ignore compiled files when auto-complete
set wildignore=*.o,*~,*.pyc

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

""""""""""""""""""""""""""""
"" The TAB key
"""""""""""""""""""""""""""

" spaces instead of tabs
set expandtab

" Tabs are 4 characters
set tabstop=4
" vim see 4 spaces as a tabstops and helps deleting them fast. 
set softtabstop=4
" autoindent uses 4 characters
set shiftwidth=4

" try to indent based on filetype 
set smartindent

"#When on, a <Tab> in front of a line inserts blanks according to
"'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
"<BS> will delete a 'shiftwidth' worth of space at the start of the
"line.
set smarttab
"
"   " Allows backspace over anything in insert mode
set backspace=indent,eol,start

" Auto save when switch buffers or lose focus
au FocusLost * silent! wa
set autowriteall

map <F4> : !make all <CR>

"search tag file up, until root directory
set tags=./tags;
set tagstack

"remove scratch/preview window
set completeopt=menu

" Wrap to next line when moving cursor
set whichwrap+=<,>,h,l,[,]
" allows the cursor to move freely
set virtualedit=block


"""""""""""""""
"" Shortcuts
""""""""""""""

" Correct typos
command! Q  quit
command! W  write
command! Wq wq 

" If, for instance, you want your text to be nicely formatted in paragraphs
" with no more than 78 characters on each line, then you could simply use it
" as:
set formatprg=par\ -w79

" Remap ctrl-] to Enter and ctrl-T to esc to make help sane.
" :au filetype help :nnoremap <buffer><CR> <c-]>
" :au filetype help :nnoremap <buffer><BS> <c-T>
"
"
""""""""""""""""""
"" Filetypes
""""""""""""""""""
"
" i.e. opens the latex-suite when a .tex file is opened. 
set ofu=syntaxcomplete#Complete


" Special indent settings for python
function SetPythonOptions()
    " indent
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2

    setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

    " more syntax highlighting
    let python_highlight_all = 1

    " Wrap at 80 chars for comments.
    setlocal formatoptions=cq textwidth=80 foldignore= wildignore+=*.py[co]
	
	" highlight current column
	setlocal cursorcolumn
    hi CursorColumn cterm=None ctermbg=DarkGrey

    setlocal colorcolumn=
endfunction

function SetXmlOptions()
    " indent
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2

	" highlight current column
	setlocal cursorcolumn
    hi CursorColumn cterm=None ctermbg=DarkGrey

    setlocal textwidth=0
    setlocal colorcolumn=
endfunction

autocmd FileType python call SetPythonOptions()
autocmd FileType xml,xsd,html call SetXmlOptions()


"""""""""""""""
"" Spellchecking
""""""""""""""
"
if v:version > 700
    " only turn spell checking on for certain file types
    function Text()
        setlocal spell spelllang=en_us
    endfunction

    autocmd BufNewFile,BufRead *.tex    call Text()
    autocmd BufNewFile,BufRead README   call Text()
    autocmd BufNewFile,BufRead *.markdown   call Text()
endif


"
""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell vim to remember certain things when we exit
" http://vim.wikia.com/wiki/VimTip80
""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='1000,\"10000,:20000,%,n~/.viminfo


" when we reload, tell vim to restore the cursor to the saved position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

if has("folding")
    function! UnfoldCur()
        if !&foldenable
            return
        endif
        let cl = line(".")
        if cl <= 1
            return
        endif
        let cf  = foldlevel(cl)
        let uf  = foldlevel(cl - 1)
        let min = (cf > uf ? uf : cf)
        if min
            execute "normal!" min . "zo"
            return 1
        endif
    endfunction
endif

augroup resCur
    autocmd!
    if has("folding")
        autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
    else
        autocmd BufWinEnter * call ResCur()
    endif
augroup END


""""""""""""""""""
"" Latex-suite
""""""""""""""""""
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
let g:Tex_Folding=0
set iskeyword+=:

""""""""""""""""""
"" Cscope settings
""""""""""""""""""
if has("cscope")
    " search cscope database first, then tags database
    set csto=0
    set cst
    set csverb

    " some shortcuts
    " C symbol
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " definition
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " functions that called by this function
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    " funtions that calling this function
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " test string
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " egrep pattern
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    " file
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " files #including this file
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

    " Automatically make cscope connections
    function! LoadCscope()
        let db = findfile("cscope.out", ".;")
        if (!empty(db))
            let path = strpart(db, 0, match(db, "/cscope.out$"))
            set nocsverb " suppress 'duplicate connection' error
            exe "cs add " . db . " " . path
            set csverb
        endif
    endfunction
    au BufEnter /* call LoadCscope()

endif

" For Eclim
" Auto open project tree view
let g:EclimProjectTreeAutoOpen=1 
let g:EclimProjectTreeExpandPathOnOpen=1


" Fix arrow keys in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Switching between windows use Ctrl + arrow
nmap <C-Up>        :wincmd k<CR>
nmap <C-Down>      :wincmd j<CR>
nmap <C-Left>      :wincmd h<CR>
nmap <C-Right>     :wincmd l<CR>

" Switch between tabs use ctrl + h,l
nmap <C-h>      gT
nmap <C-l>      gt

" yank to the system register (*) by default
set clipboard=unnamedplus

" hightlight current line num with proper background, not underline
set cursorline
hi CursorLine cterm=None
hi CursorLineNR cterm=Bold ctermbg=Cyan

" always show the status line
set laststatus=2

" status line format
" clear status line
set statusline=
" line start
set statusline+=%<
" file full path, type and flags
set statusline+=%F\ %y%m%r
" right align
set statusline+=%=              
" cursor pos
set statusline+=%([%l/%L,%c]%)\  
" persentage
set statusline+=%P

hi StatusLine cterm=bold ctermbg=DarkGray ctermfg=White

" for instant markdown
let g:instant_markdown_slow = 0

" highlight the column after textwidth
set textwidth=80
set colorcolumn=+1
hi ColorColumn ctermbg=DarkGrey

hi Pmenu cterm=bold ctermbg=5 ctermfg=White

" makes vim capable of guessing based on the filetype 
" and enable file type based plugin
" This must be put at the end of vimrc
filetype on
filetype plugin indent on
