set number
set nowrap

set tabstop=4
set shiftwidth=4
set list
set listchars=tab:__
set nocompatible
set backspace=indent,eol,start
set clipboard=unnamedplus
set hlsearch
set incsearch

syntax on

command! Tt execute 'belowright term' | execute 'resize 7'
command! Tree execute 'Fern . -drawer -toggle -reveal=all -width=40' | execute 'vertical resize 28'

command! -nargs=1 hr execute 'resize ' . <q-args>
command! -nargs=1 vr execute 'vertical resize ' . <q-args>

inoremap jj <esc>
tnoremap JJ <C-\><C-n>
vnoremap H b
vnoremap L w
nnoremap H b
nnoremap L w
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wh <C-w>h
nnoremap wl <C-w>l
nnoremap z <C-r>
nnoremap d "_d
xnoremap d "_d
xnoremap P "_dP
xnoremap p "_dp
vnoremap P "_dP
vnoremap p "_dp
nnoremap U <C-u>
nnoremap N <C-d>
nnoremap A <C-a>
nnoremap S <C-x>
nnoremap th <Cmd>execute('tabprevious')<cr>
nnoremap tl <Cmd>execute('tabnext')<cr>
nnoremap tt <Cmd>execute('Tt')<cr>
nnoremap <C-e> <Cmd>execute('Tree')<cr>
nnoremap <C-n> <C-w><C-w>
nnoremap mp <Cmd>execute('MarkdownPreview')<cr>
nnoremap BF <Cmd>execute('VimspectorReset')<cr>
nnoremap <silent> BB <Cmd>execute('normal! <Plug>VimspectorToggleBreakpoint')<cr>
nnoremap <silent> BR <Cmd>execute('normal! <Plug>VimspectorContinue')<cr>

call plug#begin('~/.vim/plugged')
 Plug 'puremourning/vimspector'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'lambdalisue/fern.vim'
 Plug 'octol/vim-cpp-enhanced-highlight'
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
call plug#end()

packloadall
packadd! vimspector

let g:vimspector_enable_mappings = 'HUMAN'

let g:coc_global_extensions = [
 \ 'coc-clangd',
 \ 'coc-python',
 \ 'coc-phpls',
 \ 'coc-json',
 \ 'coc-tsserver'
 \ ]

let g:coc_config_home = '~/.vim/coc-settings.json'

let g:fern#default_hidden=1

highlight Include ctermfg=8 guifg=#000000
highlight Function ctermfg=3 guifg=#00ff00
highlight String ctermfg=6 guifg=#ff00ff
highlight cStatement ctermfg=10 guifg=#ff0000
highlight Statement ctermfg=4 guifg=#00FF00
highlight Repeat ctermfg=4 guifg=#00FF00

autocmd FileType php setlocal expandtab
autocmd FileType php setlocal tabstop=4
autocmd FileType php setlocal shiftwidth=4
autocmd FileType php setlocal softtabstop=4
