set number
set nowrap

set tabstop=4
set shiftwidth=4
set list
set listchars=tab:__
set nocompatible

syntax on

command! Tt execute 'belowright term' | execute 'resize 7'
command! Tree execute 'Fern . -drawer -toggle -reveal=% -width=40' | execute 'vertical resize 28'

inoremap jj <esc>
tnoremap jj <C-\><C-n>
nnoremap tt :Tt<cr>
nnoremap <C-e> :Tree<cr>
nnoremap nn <C-w><C-w>
nnoremap <C-s><C-s> :VimspectorReset<cr>
" nnoremap <silent> BB <Cmd>execute('normal! <Plug>VimspectorToggleBreakpoint')<cr>
" nnoremap <silent> BR <Cmd>execute('normal! <Plug>VimspectorContinue')<cr>

call plug#begin('~/.vim/plugged')
 Plug 'puremourning/vimspector'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'lambdalisue/fern.vim'
 Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()

packloadall
packadd! vimspector

let g:vimspector_enable_mappings = 'HUMAN'

let g:coc_global_extensions = [
 \ 'coc-clangd',
 \ 'coc-python',
 \ ]
