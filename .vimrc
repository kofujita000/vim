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
set timeoutlen=500

highlight StatusLine guifg=Black guibg=DarkBlue ctermfg=Black ctermbg=DarkRed
highlight StatusLineNC guifg=Black guibg=DarkBlue ctermfg=Black ctermbg=DarkBlue
highlight StatusLineTerm guifg=DarkBlue guibg=Black ctermfg=DarkRed ctermbg=Black
highlight StatusLineTermNC guifg=DarkBlue guibg=Black ctermfg=DarkBlue ctermbg=Black
highlight VertSplit guifg=Black guibg=DarkBlue ctermfg=Black ctermbg=DarkBlue
highlight TabLine guifg=Black guibg=DarkBlue ctermfg=DarkBlue ctermbg=Black
highlight TabLineSel guifg=Black guibg=DarkBlue ctermfg=DarkRed ctermbg=Black
highlight TabLineFill guifg=Black guibg=DarkBlue ctermfg=Black ctermbg=Black

syntax on

command! Tt execute 'belowright term' | execute 'resize 7'
command! Tree execute 'Fern ./ -drawer -toggle -reveal=all -width=40' | execute 'vertical resize 28'
command! Q execute 'qa!'

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
nnoremap wH <Cmd>execute('1wincmd w')<cr>
tnoremap wJ <C-w>j
tnoremap wK <C-w>k
tnoremap wH <C-w>h
tnoremap wL <C-w>l
nnoremap wnj <Cmd>execute('belowright split')<cr>
nnoremap wnk <Cmd>execute('split')<cr>
nnoremap wnh <Cmd>execute('vs')<cr>
nnoremap wnl <Cmd>execute('belowright vs')<cr>
nnoremap wnt <Cmd>call OpenTerminal()<cr>
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
nnoremap <C-h> <Cmd>execute('wincmd H')<cr>
nnoremap mp <Cmd>execute('MarkdownPreview')<cr>
nnoremap <silent> <C-f> <Cmd>execute('VimspectorReset')<cr>
nnoremap <silent> <C-b> <Cmd>execute('normal! <Plug>VimspectorToggleBreakpoint')<cr>
nnoremap <silent> <C-r> <Cmd>execute('normal! <Plug>VimspectorContinue')<cr>
nnoremap <silent> <C-a> <F10>
nnoremap <silent> <C-s> <F11>
nnoremap <client> <C-d> <F12>
map f <Plug>Sneak_f
map F <Plug>Sneak_F

call plug#begin('~/.vim/plugged')
 Plug 'puremourning/vimspector'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'lambdalisue/fern.vim'
 Plug 'octol/vim-cpp-enhanced-highlight'
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
 Plug 'airblade/vim-gitgutter'
 Plug 'justinmk/vim-sneak'
 Plug 'tpope/vim-fugitive'
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
let g:fern#renderer = 'lightline'
let g:fern#renderer_options = {
  \ 'full_path': 0,
  \ 'draw_devicons': 0,
  \ 'column': 0,
  \ 'go_to_input': 1,
  \ 'winwidth': 30,
  \ 'winminwidth': 30,
  \ }

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1

highlight SignColumn guibg=NONE ctermbg=NONE

" Define custom highlight groups for gitgutter signs
highlight GitGutterAdd    guifg=#00ff00 ctermfg=2 guibg=NONE ctermbg=NONE
highlight GitGutterChange guifg=#ffff00 ctermfg=3 guibg=NONE ctermbg=NONE
highlight GitGutterDelete guifg=#ff0000 ctermfg=1 guibg=NONE ctermbg=NONE

autocmd BufWritePost * GitGutter

" " Map gitgutter signs to custom highlight groups
" let g:gitgutter_override_sign_column_highlight = 1
" highlight link GitGutterAddSign    GitGutterAdd
" highlight link GitGutterChangeSign GitGutterChange
" highlight link GitGutterDeleteSign GitGutterDelete

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

function! OpenTerminal()
 " ターミナルを非同期で開く
 execute 'term'

 execute 'wincmd w'

 execute 'q'
endfunction

" カレントディレクトリに .vimrc が存在する場合、それを読み込む
if getcwd() != $HOME && filereadable(".vimrc")
  source .vimrc
endif

autocmd BufEnter * if isdirectory(expand('%')) | execute 'edit .' | execute 'Tree' | endif
