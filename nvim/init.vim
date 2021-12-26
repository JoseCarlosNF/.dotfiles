call plug#begin('~/.vim/plugged')

" LSP
Plug 'neovim/nvim-lspconfig'

" NERDTree. Mas, só carrega quando pede
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  \| Plug 'Xuyuanp/nerdtree-git-plugin'
  \| Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Tema brabissímo
Plug 'sainnhe/gruvbox-material'

" Aquele status bunitu
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Pack de icones, pra ficar xuxuzinho
Plug 'ryanoasis/vim-devicons'

call plug#end()

"                              Load: Lua configs
lua require('joselito')

"                            General: configurations
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nrformats+=alpha

set encoding=utf-8
set textwidth=80
set cursorline
set number
set relativenumber
set linebreak
set mouse=a

syntax enable
set lcs=eol:⏎,tab:->,trail:~,nbsp:⎵,space:·

"                                  Shortcuts: keyboard mappings
nmap <F2> :set invlist<CR>
imap <F2> <ESC>:set invlist<CR>a
map <F23> :set hlsearch!<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
filetype plugin indent on

" Gruvbox: Options
if has('termguicolors')
  set termguicolors
endif
set background=dark

let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_ui_contrast = 'high'

colorscheme gruvbox-material

" NerdTree: options
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeIgnore=['\.class', '\.pyc$', '\.pyo$', '__pycache__$', 'venv']

" NerdTree: shorcuts
map <C-n> :NERDTreeToggle<CR>
"Switch between different windows by their direction`
no <S-Down> <C-w>j| "switching to below window
no <S-Up> <C-w>k| "switching to above window
no <S-Right> <C-w>l| "switching to right window
no <S-Left> <C-w>h| "switching to left window

" Airline: HUD
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
"" Barra de status
let g:airline_powerline_fonts = 1
"" Barra superior
let g:airline#extensions#tabline#enabled = 1

" DevIcons: Settings related on file icons
set encoding=utf8
set guifont=VictorMono\ Nerd\ Font\ 10
let g:airline_powerline_fonts = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {
      \ "docker-compose.*\\c": ''
      \ }

" NerdTree: git integration
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

" Spell: spellchecker
highlight SpellCap ctermfg=White ctermbg=DarkBlue
highlight SpellBad ctermfg=White ctermbg=DarkRed 
autocmd FileType text setlocal spell spelllang=pt,en
autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=pt,en
