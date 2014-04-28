" tab size
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" use pyflakes checker for syntastic
let g:syntastic_python_checkers = ['pyflakes']

" Do not wrap long lines for code
set formatoptions-=t
