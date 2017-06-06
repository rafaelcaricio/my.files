syntax on
set eol
set number
set splitbelow
set splitright
set backspace=indent,eol,start
set clipboard=unnamed
" show existing tab with 4 spaces width
set tabstop=4
let mapleader=","
nnoremap <leader>v :split<cr>
nnoremap <leader>w :vsplit<cr>
" split navigation
nnoremap <BS> <C-W>h
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <c->> <c-W>>
filetype plugin indent on
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Remote trailing whitespace
nnoremap <Leader>ns :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <Leader><SPACE> :noh<CR>

" Plugins management
call plug#begin('~/.vim/plugged')

" Isort for Python code
function! ConfigureIsort(info)
endfunction

Plug 'rafaelcaricio/vim-isort', { 'do': function('ConfigureIsort') }

call plug#end()

nnoremap <leader>is :Isort<cr>
