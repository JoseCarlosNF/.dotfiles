call plug#begin('~/.vim/plugged')

" Servidor para autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'honza/vim-snippets'

" Alinha facil: alinhador de conteúdo
Plug 'junegunn/vim-easy-align'

" NERDTree. Mas, só carrega quando pede
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  \| Plug 'Xuyuanp/nerdtree-git-plugin'
  \| Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Tema brabissímo
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'olimorris/onedarkpro.nvim'

" Aquele status bunitu
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Pack de icones, pra ficar xuxuzinho
Plug 'ryanoasis/vim-devicons'

"" Sinalizador de identação
Plug 'Yggdroot/indentLine'

"" Linter assíncrono
"" Plug 'dense-analysis/ale'

" Harshicorp:
Plug 'hashivim/vim-vagrant'
Plug 'hashivim/vim-terraform'

" TODO: bonitão
"Plug 'nvim-lua/plenary.nvim'
"Plug 'folke/todo-comments.nvim'

""Rainbow Parentheses"
"Plug 'frazrepo/vim-rainbow'

""Autoformat suporte para varias linguagens"
"Plug 'Chiel92/vim-autoformat'

call plug#end()

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
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
filetype plugin indent on

" CoC: Shortcut to autocomplete
inoremap <silent><expr> <c-space> coc#refresh()

" Onedark: 
" let g:onedark_hide_endofbuffer=0
" let g:onedark_termcolors=256
" let g:onedark_terminal_italics=1
" let g:airline_theme='onedark'
" colorscheme onedark

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

" Rainbow: Parentheses Improved
" autocmd FileType c,cpp,python,json,yaml,dockerfile call rainbow#load()
" let g:rainbow_load_separately = [
"     \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"     \ ]
" 
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['LightBlue', 'DarkGreen', 'Yellow', 'Red', 'Magenta']

" Spell: spellchecker
highlight SpellCap ctermfg=White ctermbg=DarkBlue
highlight SpellBad ctermfg=White ctermbg=DarkRed 
autocmd FileType text setlocal spell spelllang=pt,en
autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=pt,en

" Opções do identador
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']

" Pra não ter dor de cabeça com YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldlevelstart=20

" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_sign_error = ''
" let g:ale_sign_warning = ''
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_set_highlights = 1

" Python: provider
let g:loaded_python_provider = 1
let g:python3_host_prog = '~/.pyenv/shims/python'
let g:virtualenv_directory = 'venv'
let g:python_pep8_indent_hang_closing = 0

" Treesitter: parse of most languages
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  }
}
EOF
