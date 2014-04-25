"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" git status in gutter
Plugin 'airblade/vim-gitgutter'

" eclim
Plugin 'initrc/eclim-vundle'

" pyflakes
Plugin 'kevinw/pyflakes-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use all the bells and whistles of Vim compared to vi
set nocompatible

" Turns on syntax highlighting 
syntax on

" Set the syntax color scheme 
colorscheme elflord

" Optimize the colors to a dark background
set background=dark

" Show the line and column number of the cursor position
set ruler

" Show line number
set nu

" Show (partial) command in the last line of the screen.
set showcmd

" When a bracket is inserted, briefly jump to the matching one. 
set showmatch

" make shell think it's invoked as login shell
set shell=/bin/bash\ -l

" remember recent commands
set history=100

" Auto save all files
set autowriteall

" Wrap to next line when moving cursor
set whichwrap+=<,>,h,l,[,]

" allows the cursor to move freely in visual mode
set virtualedit=block

" text width
set textwidth=80

" highlight the column after textwidth
if version >= 703
    set colorcolumn=+1
endif

" hightlight current line num
set cursorline





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always show the status line
set laststatus=2

" clear status line
set statusline=

" reset to line start
set statusline+=%<

" file full path, with a whitespace
set statusline+=%F\ 

" file type
set statusline+=%y

" modified flag
set statusline+=%m

" readonly flag
set statusline+=%r

" right align
set statusline+=%=              

" cursor pos
set statusline+=%([%l/%L,%c]%)\  

" persentage
set statusline+=%P





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight groups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" column
hi ColorColumn ctermbg=DarkGrey

" cursor line
hi CursorLine cterm=None

" cursor line number
hi CursorLineNR cterm=Bold ctermbg=Cyan

" status line
hi StatusLine cterm=bold ctermbg=DarkGray ctermfg=White


" git gutter
hi GitGutterAdd cterm=bold ctermfg=Green
hi GitGutterChange cterm=bold ctermfg=Yellow
hi GitGutterDelete cterm=bold ctermfg=Red
hi GitGutterChangeDelete cterm=bold ctermfg=Yellow





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Switching between windows use Ctrl + hjkl
nmap <C-k>          :wincmd k<CR>
nmap <C-j>          :wincmd j<CR>
nmap <C-h>          :wincmd h<CR>
nmap <C-l>          :wincmd l<CR>





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indention
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" autoindent uses 4 characters
set shiftwidth=4

" Auto indent
set autoindent

" Enable file type base indent
filetype plugin indent on





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight searches 
set hlsearch

" While typing a search command, show where the pattern, as it was typed so
" far matches.  
set incsearch

" If a search only contains small chars it Vim ignores cases and if the
" search contains large chars Vim will search for the case-sensitive string
set smartcase





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAB
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" spaces instead of tabs
set expandtab

" Tabs are 4 characters
set tabstop=4

" vim see 4 spaces as a tabstops and helps deleting them fast. 
set softtabstop=4

" A <Tab> in front of a line inserts blanks according to 'shiftwidth'.  
" 'tabstop' or 'softtabstop' is used in other places.  A
" <BS> will delete a 'shiftwidth' worth of space at the start of the
"line.
set smarttab





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persist Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('persistent_undo')
    " Enable undo file
    set undofile

    "maximum number of changes that can be undone
    set undolevels=1000

    "maximum number lines to save for undo on a buffer reload
    set undoreload=1000

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





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWP files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Try to store all swp files in one place
silent !mkdir -p $HOME/.vimswp
set dir=$HOME/.vimswp//





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim info
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" clear viminfo
set viminfo=

" files for which marks are remembered
set viminfo+='1000

" items in search history
set viminfo+=/1000

" command line history
set viminfo+=:1000

" lines for each register
set viminfo+=<100

" viminfo file name
set viminfo+=n~/.viminfo





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Restore the cursor to the saved position
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
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





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
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





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" yank to the system register (*) by default
set clipboard=unnamedplus





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Eclim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto open project tree view
let g:EclimProjectTreeAutoOpen=1 
let g:EclimProjectTreeExpandPathOnOpen=1





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git gutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always show sign column
let g:gitgutter_sign_column_always = 1





"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Have VIM auto load changed files
" from http://vim.wikia.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
