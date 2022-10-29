-------------------------------- Basic Options --------------------------------

vim.opt.tabstop         = 2
vim.opt.softtabstop     = 2
vim.opt.shiftwidth      = 2
vim.opt.expandtab       = true
vim.opt.nrformats       = 'alpha'

vim.opt.encoding        = 'utf-8'
vim.opt.textwidth       = 80
vim.opt.cursorline      = true
vim.wo.number           = true
vim.opt.relativenumber  = true
vim.opt.linebreak       = true
vim.opt.mouse           = 'a'

vim.opt.foldmethod      = 'expr'
-- vim.opt.foldexpr        = 'nvim_treesitter#foldexpr()'
vim.opt.termguicolors   = true
vim.opt.background      = 'dark'

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
  auto_install      = true,

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
    theme = 'gruvbox-material',
    disabled_filetypes = { 'packer', 'NvimTree' } -- hide status bar when using Nvim-Tree
  }
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
  renderer = {
    group_empty = false,
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

--------------------------- Package Manager: Packer ---------------------------

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'sainnhe/gruvbox-material'
  use 'folke/todo-comments.nvim'
  use 'nvim-lualine/lualine.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly'
  }
end)
