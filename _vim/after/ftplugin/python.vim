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
