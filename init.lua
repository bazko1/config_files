-- Disable netrw
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1


vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy nvim if it"s not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Theme
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'darker'
      })
      require('onedark').load()
      vim.cmd.colorscheme 'onedark'
    end
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {'j-hui/fidget.nvim', tag = 'legacy', opts = {}},

      -- Additional lua configuration, makes nvim stuff amazing!
      {'folke/neodev.nvim', opts = {}}
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_b = {'filename'},
        lualine_c = {'branch'},
        lualine_x = {'diagnostics'},
        lualine_y = {},
      },
    },
  },

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    opts = {
      defaults = {
        file_ignore_patterns = {
          ".git"
        },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<Esc><Esc>"] = "close",
          },
          n = {
            ["<Esc><Esc>"] = "close",
          }
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      live_grep = {
        additional_args = function()
          return { '--hidden', '--glob', '!**/.git/*' }
        end
      },
      grep_string = {
        additional_args = function()
          return { '--hidden', '--glob', '!**/.git/*' }
        end
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

},{})

-- vim opts

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- copy indent from current line when starting new one
vim.opt.autoindent = true
-- expand tabs
vim.opt.expandtab = true
-- indents smart
vim.opt.smartindent = true
-- enable 24-but rgb color in the TUI
vim.opt.termguicolors = true
-- line wrapping
-- do not use linewrap by default
vim.opt.wrap = false
-- do not break by words at the end of the line
vim.opt.linebreak = false
-- Make line numbers default
vim.wo.number = true
vim.opt.number = true
-- Disable swap files
vim.opt.swapfile = false
-- spellcheck disable
vim.opt.spell = false
-- make copy into * clipboard by default
vim.opt.clipboard = {"unnamedplus", "unnamed"}
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true

-- keymaps
-- nohl on double esc
vim.keymap.set({"n"},"<Esc><Esc>", ":let @/ = ''<CR>", { silent = true })
-- use ; as : very convenient as not need to hold shift
vim.keymap.set({"n","v","o"}, ";", ":")
-- instead the repeat f, t command is set to ,
vim.keymap.set({"n","v","o"}, ",", ";")
-- repeat back f, t command is set to leader + ,
vim.keymap.set({"n","v","o"}, "<Leader>,", ",")

-- telescope configuration
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>b', function()
  require('telescope.builtin').buffers {sort_lastused=true}
end, { desc = 'Search [B]uffers' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch [G]rep' })

-- lsp configuration
require('mason').setup()
require('mason-lspconfig').setup()
local servers = {
  gopls = {},
  -- pyright = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      }
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      -- on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}
