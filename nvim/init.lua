-------------------------------- Basic Options --------------------------------

vim.opt.tabstop         = 2
vim.opt.softtabstop     = 2
vim.opt.shiftwidth      = 2
vim.opt.expandtab       = true
vim.opt.nrformats       = 'alpha'
vim.opt.ignorecase      = true

vim.opt.encoding        = 'utf-8'
vim.opt.textwidth       = 80
vim.opt.cursorline      = true
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.linebreak       = true
vim.opt.mouse           = 'a'
vim.opt.scrolloff       = 3
vim.opt.swapfile        = false
vim.opt.updatetime      = 300
vim.opt.undofile        = true
vim.opt.clipboard       = 'unnamedplus'

vim.opt.foldmethod      = 'expr'
-- vim.opt.foldexpr        = 'nvim_treesitter#foldexpr()'
vim.opt.termguicolors   = true
vim.opt.background      = 'dark'
vim.opt.conceallevel    = 2


--------------------------------- Spell check ---------------------------------

vim.api.nvim_create_autocmd(
  {'BufNewFile', 'BufRead'},
  {
    pattern = {'*.md'},
    command = 'setlocal spell spelllang=pt,en'
  }
)
vim.api.nvim_set_hl(0, 'SpellRare', { cterm=underline, ctermfg=White, ctermbg=Yellow })
vim.api.nvim_set_hl(0, 'SpellLocal', { cterm=underline, ctermfg=White, ctermbg=Green })
vim.api.nvim_set_hl(0, 'SpellCap', { cterm=underline, ctermfg=White, ctermbg=DarkBlue })
vim.api.nvim_set_hl(0, 'SpellBad', { cterm=underline, ctermfg=White, ctermbg=DarkRed })

----------------------------------- Mapping -----------------------------------

vim.api.nvim_set_keymap('n', '<F23>', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-B>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

---------------------------- Color Scheme: Gruvbox ----------------------------

vim.g.gruvbox_material_background                 = 'hard'
vim.g.gruvbox_material_foreground                 = 'original'

vim.g.gruvbox_material_disable_italic_comment     = 0
vim.g.gruvbox_material_enable_bold                = 1
vim.g.gruvbox_material_enable_italic              = 1

vim.g.gruvbox_material_cursor                     = 'auto'
vim.g.gruvbox_material_transparent_background     = 2
vim.g.gruvbox_material_menu_selection_background  = 'yellow'
vim.g.gruvbox_material_sign_column_background     = 'grey'
vim.g.gruvbox_material_spell_foreground           = 'colored'
vim.g.gruvbox_material_ui_contrast                = 'high'

vim.g.gruvbox_material_better_performance         = 1
vim.cmd('colorscheme gruvbox-material')

------------------------------- Nvim-Treesitter -------------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed  = { 'python', 'dockerfile', 'make', 'hcl', 'bash', 'go' },
  sync_install      = false,
  auto_install      = false,

  highlight = { enable = true, additional_vim_regex_highlighting = true },
}

-------------------------------- TODO Comments --------------------------------

require('todo-comments').setup {
  keywords = {
    FIX = {
      icon = ' ',
      color = 'error',
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
    },
    TODO = { icon = ' ', color = 'info' },
    HACK = { icon = ' ', color = 'warning' },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
    PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
  },
  merge_keywords = false,
  highlight = {
    before = ' ', -- 'fg' or 'bg' or empty
    keyword = 'wide', -- 'fg', 'bg', 'wide' or empty
    after = 'fg', -- 'fg' or 'bg' or empty
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  colors = {
    error = { 'LspDiagnosticsDefaultError', 'ErrorMsg', '#fb4934' },
    warning = { 'LspDiagnosticsDefaultWarning', 'WarningMsg', '#fabd2f' },
    info = { 'LspDiagnosticsDefaultInformation', '#83a598' },
    hint = { 'LspDiagnosticsDefaultHint', '#8ec07c' },
    default = { 'Identifier'},
  }
}

----------------------------- Status bar: lualine -----------------------------

require('lualine').setup {
  options = {
    theme = 'gruvbox_dark',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'packer', 'NvimTree' } -- hide status bar when using Nvim-Tree
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename', 'branch'},
    lualine_c = {'fileformat'},
    lualine_x = {'diff', 'diagnostics'},
    lualine_y = {'filetype', 'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

------------------------- File explorer: nvim-tree.lua -------------------------

vim.g.loaded_newtrw       = 1
vim.g.loaded_newtrwPlugin = 1

local lib = require('nvim-tree.lib')

local git_add = function()
  local node = lib.get_node_at_cursor()
  local gs = node.git_status

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
    vim.cmd('silent !git add ' .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == 'M ' or gs == 'A ' then
    vim.cmd('silent !git restore --staged ' .. node.absolute_path)
  end

  lib.refresh_tree()
end

require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = 'u', action = 'dir_up' },
        { key = 'ga', action = 'git_add', action_cb = git_add },
      },
    },
  },
  git = {
    enable = true,
  },
  renderer = {
    group_empty = false,
    highlight_git = true,
  },
  filters = {
    dotfiles = true,
  },
})

----------------------------------- CoC.Nvim -----------------------------------

-- Python: provider
vim.g.loaded_python_provider          = 1
vim.g.python3_host_prog               = '~/.pyenv/shims/python'
vim.g.virtualenv_directory            = 'venv'
vim.g.python_pep8_indent_hang_closing = 0

------------------------------ Highligth: Colors ------------------------------

require('nvim-highlight-colors').setup {}

--------------------------- Highligth: Indent lines ---------------------------

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#fb4934 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#b8bb26 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#fabd2f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#458588 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#b16286 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#689d6a gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}

--------------------------- Package Manager: Packer ---------------------------

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'sainnhe/gruvbox-material'
  use 'folke/todo-comments.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'brenoprata10/nvim-highlight-colors'
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
	use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly'
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {'nvim-lua/plenary.nvim'}
  }
end)
