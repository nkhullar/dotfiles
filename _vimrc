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

" Show (partial) command in the last line of the screen.
set showcmd

" Set history 
set history=9999

" Persist undo
if has('persistent_undo')
    set undofile
    "maximum number of changes that can be undone
    set undolevels=9999 
    "maximum number lines to save for undo on a buffer reload
    set undoreload=9999 

    " If have Dropbox installed, create a undo dir in it
    if isdirectory(expand("$HOME/Dropbox/"))
        silent !mkdir -p $HOME/Dropbox/.vimundo >/dev/null 2>&1
        set undodir=$HOME/Dropbox/.vimundo//
    else
        " Otherwise, keep them in home
        silent !mkdir -p $HOME/.vimundo >/dev/null 2>&1
        set undodir=$HOME/.vimundo//
    end
endif

" Set to auto read when a file is changed from the outside
set autoread

" Try to store all swp files in one place
silent !mkdir -p $HOME/.vimswp
set dir=$HOME/.vimswp//

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
set formatprg="fmt -w 79"

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

    " do not remove indent of #
    inoremap # X#

    " more syntax highlighting
    let python_highlight_all = 1

    " Wrap at 80 chars for comments.
    setlocal formatoptions=cq textwidth=80 foldignore= wildignore+=*.py[co]

    " highlight current column
    setlocal cursorcolumn
    hi CursorColumn cterm=None ctermbg=DarkGrey

endfunction

function SetRubyOptions()
    " indent
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2

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
autocmd FileType ruby call SetRubyOptions()
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

" Switching between windows use Ctrl + hjkl
nmap <C-k>        :wincmd k<CR>
nmap <C-j>      :wincmd j<CR>
nmap <C-h>      :wincmd h<CR>
nmap <C-l>     :wincmd l<CR>

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
if version >= 703
    set colorcolumn=+1
endif
hi ColorColumn ctermbg=DarkGrey

hi Pmenu cterm=bold ctermbg=5 ctermfg=White


"""""""""""""""""""""""""""""""""""""""
" Have VIM auto load changed files
" from http://vim.wikia.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally
"""""""""""""""""""""""""""""""""""""""
" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})

" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
    " Figure out which options are in effect
    if a:bufname == '*'
        let id = 'WatchForChanges'.'AnyBuffer'
        " If you try to do checktime *, you'll get E93: More than one match for * is given
        let bufspec = ''
    else
        if bufnr(a:bufname) == -1
            echoerr "Buffer " . a:bufname . " doesn't exist"
            return
        end
        let id = 'WatchForChanges'.bufnr(a:bufname)
        let bufspec = a:bufname
    end

    if len(a:000) == 0
        let options = {}
    else
        if type(a:1) == type({})
            let options = a:1
        else
            echoerr "Argument must be a Dict"
        end
    end
    let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
    let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
    let disable     = has_key(options, 'disable')     ? options['disable']     : 0
    let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
    let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0

    if while_in_this_buffer_only
        let event_bufspec = a:bufname
    else
        let event_bufspec = '*'
    end

    let reg_saved = @"
    "let autoread_saved = &autoread
    let msg = "\n"

    " Check to see if the autocommand already exists
    redir @"
    silent! exec 'au '.id
    redir END
    let l:defined = (@" !~ 'E216: No such group or event:')

    " If not yet defined...
    if !l:defined
        if l:autoread
            let msg = msg . 'Autoread enabled - '
            if a:bufname == '*'
                set autoread
            else
                setlocal autoread
            end
        end
        silent! exec 'augroup '.id
        if a:bufname != '*'
            "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
            "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
            exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
        end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec

        " The following events might slow things down so we provide a way to disable them...
        " vim docs warn:
        "   Careful: Don't do anything that the user does
        "   not expect or that is slow.
        if more_events
            exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
            exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
        end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
end

" If they want to disable it, or it is defined and they want to toggle it,
if l:disable || (l:toggle && l:defined)
    if l:autoread
        let msg = msg . 'Autoread disabled - '
        if a:bufname == '*'
            set noautoread
        else
            setlocal noautoread
        end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
end

" echo msg
let @"=reg_saved
endfunction


au BufNewFile,BufRead *.log :WatchForChanges

" makes vim capable of guessing based on the filetype 
" and enable file type based plugin
" This must be put at the end of vimrc
filetype on
filetype plugin indent on
filetype plugin on
