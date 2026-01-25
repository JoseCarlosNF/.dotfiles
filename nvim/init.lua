-------------------------------- Basic Options --------------------------------

vim.opt.tabstop         = 4
vim.opt.softtabstop     = 4
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true
vim.opt.nrformats       = 'alpha'
vim.opt.ignorecase      = true

vim.opt.encoding        = 'utf-8'
vim.opt.textwidth       = 79
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


----------------------------------- Mapping -----------------------------------

vim.api.nvim_set_keymap('n', '<F23>', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-B>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Space>', 'v:lua.require("coc").refresh()', { silent = true, expr = true })

--------------------------------- Spell check ---------------------------------

vim.api.nvim_create_autocmd(
  {'BufNewFile', 'BufRead'},
  {
    pattern = {'*.md'},
    command = 'setlocal spell spelllang=pt,en'
  }
)

----------------------------- Telescope: Mapping ----------------------------- 

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fe', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

--------------------------- Color Scheme: Solarized ---------------------------
-- -- Example config in lua
-- vim.g.solarized_italic_comments = true
-- vim.g.solarized_italic_keywords = true
-- vim.g.solarized_italic_functions = true
-- vim.g.solarized_italic_variables = false
-- vim.g.solarized_contrast = true
-- vim.g.solarized_borders = false
-- vim.g.solarized_disable_background = true
-- 
-- -- Load the colorscheme
-- require('solarized').set()

--------------------------- Color Scheme: Gruvbox ----------------------------

-- vim.g.gruvbox_material_background                 = 'hard'
-- vim.g.gruvbox_material_foreground                 = 'original'
-- 
-- vim.g.gruvbox_material_disable_italic_comment     = 0
-- vim.g.gruvbox_material_enable_bold                = 1
-- vim.g.gruvbox_material_enable_italic              = 1
-- 
-- vim.g.gruvbox_material_cursor                     = 'auto'
-- vim.g.gruvbox_material_transparent_background     = 2
-- vim.g.gruvbox_material_menu_selection_background  = 'yellow'
-- vim.g.gruvbox_material_sign_column_background     = 'grey'
-- vim.g.gruvbox_material_spell_foreground           = 'colored'
-- vim.g.gruvbox_material_ui_contrast                = 'high'
-- 
-- vim.g.gruvbox_material_better_performance         = 1
-- vim.cmd('colorscheme gruvbox-material')

--------------------------- Color Scheme: One Dark ---------------------------
vim.cmd('colorscheme onedark')
-- Lua
require('onedark').setup  {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
       comments = 'italic',
       functions = 'italic,bold',
       strings = 'italic',
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    highlights = {
        SpellBad =   {fg = '$red',    fmt = "undercurl,italic", sp = '$red'     },
        SpellCap =   {fg = '$yellow', fmt = "undercurl,italic", sp = '$yellow'  },
        SpellLocal = {fg = '$blue',   fmt = "undercurl,italic", sp = '$blue'    },
        SpellRare =  {fg = '$purple', fmt = "undercurl,italic", sp = '$purple'  },
    },

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('onedark').load()

------------------------------- Nvim-Treesitter -------------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed  = { 'python', 'dockerfile', 'make', 'hcl', 'bash', 'go' },
  sync_install      = false,
  auto_install      = false,

  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
  rainbow = { enable = true, extended_mode = true, max_file_lines = nil }
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
    theme = 'onedark',
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
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = true,
    custom = {
        "__pycache__"
    },
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

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#fb4934 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#b8bb26 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#fabd2f gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#458588 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#b16286 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#689d6a gui=nocombine]]
-- 
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- 
-- require("indent_blankline").setup {
--   char_highlight_list = {
--     "IndentBlanklineIndent1",
--     "IndentBlanklineIndent2",
--     "IndentBlanklineIndent3",
--     "IndentBlanklineIndent4",
--     "IndentBlanklineIndent5",
--     "IndentBlanklineIndent6",
--   },
-- }
require('ibl').setup {
    scope = {
        enabled = false,
       show_start = false,
       show_end = false,
    }
}

-------------------------------- filetype.nvim --------------------------------
require("filetype").setup {
  overrides = {
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      tfstate = "json",
    },
  },
}

--------------------------- Package Manager: Packer ---------------------------

return require('packer').startup(function(use)
    use 'navarasu/onedark.nvim'  use 'neoclide/jsonc.vim'
  use 'nathom/filetype.nvim'
  use 'vimwiki/vimwiki'
  use 'mtdl9/vim-log-highlighting'
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
  use 'nvim-treesitter/nvim-treesitter'
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
