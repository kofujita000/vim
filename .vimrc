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
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%{&fileencoding}]\ [POS=%l,%c]\ [%p%%]
set laststatus=2
set directory=${HOME}/.vim/swap/
set directory^=${HOME}/.vim/swap//,%:p/

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
command! Q execute 'mksession! .session.vim' | execute 'qa!'

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
nnoremap <silent> tq <Cmd>execute('tabclose')<cr>
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

function! JumpToDefinitionInNewTab()
 let l:cursor_pos = getpos(".")
 let current_file = expand('%:p')
 execute 'tabnew'
 execute 'edit' current_file
 execute "call setpos('.', l:cursor_pos)"
 execute "call CocAction('jumpDefinition')"
endfunction

function! GetCurrentFunctionName()
  let l:symbols = CocAction('documentSymbols')
  let l:line = line('.')

  " Iterate over symbols to find the current function
  for l:symbol in reverse(l:symbols)
    if l:symbol['kind'] == 'Function'
      if l:symbol['lnum'] == l:line
        " Copy the function name to clipboard and return it
        return l:symbol['text']
      endif
    endif
  endfor

  echo 'Function not found'
  return ''
endfunction

function! SwitchSourceHeader()
  " Save the current cursor position and file path
  let l:cursor_pos = getpos(".")
  let l:current_file = expand('%:p')
  let l:func_name = GetCurrentFunctionName()

  tabnew
  edit l:current_file

  execute "call setpos('.', l:cursor_pos)"

  " Switch source/header files using clangd
  execute "call CocAction('runCommand', 'clangd.switchSourceHeader')"

  " Wait for CocAction to complete and then update the list of symbols
  let l:symbols = CocAction('documentSymbols')
  let l:line = line('.')

  " Iterate over symbols to find the function definition in the new file
  for l:symbol in reverse(l:symbols)
    if l:symbol['kind'] == 'Function'
      if l:symbol['text'] == l:func_name
        " Move the cursor to the function definition
        execute "call cursor(l:symbol['lnum'], l:symbol['col'])"
        return
      endif
    endif
  endfor

  " If function is not found, show a message
  echo 'Function definition not found in the new file'
endfunction

nnoremap <silent> M  <cmd>execute('call JumpToDefinitionInNewTab()')<cr>
nnoremap <silent> gf <cmd>execute('call SwitchSourceHeader()')<cr>

call plug#begin('~/.vim/plugged')
 Plug 'puremourning/vimspector'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'lambdalisue/fern.vim'
 Plug 'octol/vim-cpp-enhanced-highlight'
 Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
 Plug 'airblade/vim-gitgutter'
 Plug 'justinmk/vim-sneak'
 Plug 'tpope/vim-fugitive'
 Plug 'nelstrom/vim-visual-star-search'
 Plug 'jreybert/vimagit'
 Plug 'yaocccc/vim-hlchunk'

 Plug 'kofujita000/vim-surround-char'
call plug#end()

packloadall
packadd! vimspector

let g:vimspector_enable_mappings = 'HUMAN'

let g:coc_global_extensions = [
 \ 'coc-clangd',
 \ 'coc-python',
 \ 'coc-phpls',
 \ 'coc-json',
 \ 'coc-tsserver',
 \ 'coc-java',
 \ 'coc-julia'
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

autocmd FileType cpp setlocal expandtab
autocmd FileType cpp setlocal tabstop=4
autocmd FileType cpp setlocal shiftwidth=4
autocmd FileType cpp setlocal softtabstop=4

autocmd FileType h setlocal expandtab
autocmd FileType h setlocal tabstop=4
autocmd FileType h setlocal shiftwidth=4
autocmd FileType h setlocal softtabstop=4

autocmd FileType php setlocal expandtab
autocmd FileType php setlocal tabstop=4
autocmd FileType php setlocal shiftwidth=4
autocmd FileType php setlocal softtabstop=4
autocmd FileType php highlight phpFunctions ctermfg=3 guifg=#00ff00

autocmd FileType java setlocal expandtab
autocmd FileType java setlocal tabstop=4
autocmd FileType java setlocal shiftwidth=4
autocmd FileType java setlocal softtabstop=4
autocmd FileType java highlight javaFunctions ctermfg=3 guifg=#00ff00

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

if argc() == 0 && filereadable(".session.vim")
  silent! source .session.vim
endif

autocmd BufEnter * if isdirectory(expand('%')) | execute 'edit .' | execute 'Tree' | endif

" what files are supported, default '*.ts,*.js,*.json,*.go,*.c'
  let g:hlchunk_files = '*.ts,*.js,*.json,*.go,*.c,*.cpp,*.php,*.h'
" highlight
  au VimEnter * hi IndentLineSign ctermfg=248
" delay default 50
  let g:hlchunk_time_delay = 50
" signpriority default 90
  let g:hlchunk_priority = 90
" hlchunk_theme_preset default 1
  let g:hlchunk_theme = 1
" hlchunk_theme_byuser default NULL
" format: sign_texts: char[2][3], usenew: (0|1)[4] " [start end, middle]
  let g:hlchunk_theme_byuser = { 'sign_texts': ['╭─', '│ ', '╰>'], 'usenew': [1, 1, 1, 1] }

highlight VisualHighlight ctermbg=Yellow ctermfg=Black
let g:highlight_ids=[]

vnoremap <silent> mk :<C-u>let id = matchadd('VisualHighlight', '\%'.line("'<").'l\%'.col("'<").'c\_.*\%'.line("'>").'l\%'.(col("'>")+1).'c') \| call add(g:highlight_ids, id)<cr>

function! ClearHighlight()
  for id in g:highlight_ids
    if id != -1
      call matchdelete(id)
    endif
  endfor
  let g:highlight_ids = []
endfunction

nnoremap <silent> mc :<C-u>call ClearHighlight()<cr>
