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
set timeoutlen=200

syntax on

command! Tt execute 'belowright term' | execute 'resize 7'
command! Tree execute 'Fern . -drawer -toggle -reveal=all -width=40' | execute 'vertical resize 28'

nnoremap rh :resize 
nnoremap rv :vertical resize 
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
tnoremap WJ <C-w>j
tnoremap WK <C-w>k
tnoremap WH <C-w>h
tnoremap WL <C-w>l
nnoremap wnj <Cmd>execute('belowright new')<cr>
nnoremap wnk <Cmd>execute('new')<cr>
nnoremap wnh <Cmd>execute('leftabove vs')<cr>
nnoremap wnl <Cmd>execute('vs')<cr>
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
nnoremap tnh <Cmd>execute('tabnew') \| execute('tabm -1')<cr>
nnoremap tnl <Cmd>execute('tabnew')<cr>
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
 Plug 'airblade/vim-gitgutter'
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

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=darkgrey

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

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    " Fallback to Vim's native K command for non-LSP buffers
    normal! K
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
