call plug#begin('~/.vim/plugged')

" NERDTree. Mas, só carrega quando pede
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  \| Plug 'Xuyuanp/nerdtree-git-plugin'
  \| Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Sinalizador de identação
Plug 'Yggdroot/indentLine'

call plug#end()

"                            General: configurations
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nrformats+=alpha

set encoding=utf-8
set cursorline
set number
set linebreak
set mouse=a

syntax enable
set lcs=eol:⏎,tab:->,trail:~,nbsp:⎵,space:·

"                        Shortcuts: keyboard mappings
nmap <F2> :set invlist<CR>
imap <F2> <ESC>:set invlist<CR>a
map <F23> :set hlsearch!<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"                             NerdTree: options
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeIgnore=['\.class', '\.pyc$', '\.pyo$', '__pycache__$', 'venv']

"                             NerdTree: shorcuts
map <C-n> :NERDTreeToggle<CR>
"Switch between different windows by their direction`
no <S-Down> <C-w>j| "switching to below window
no <S-Up> <C-w>k| "switching to above window
no <S-Right> <C-w>l| "switching to right window
no <S-Left> <C-w>h| "switching to left window

"                         NerdTree: git integration
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'',
                \ }

" IndentLine: characters used to indent
let g:indentLine_char_list = ['▏']
