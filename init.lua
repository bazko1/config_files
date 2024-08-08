-- Disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

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
        style = 'deep'
      })
      require('onedark').load()
      vim.cmd.colorscheme 'onedark'
      vim.opt.background = 'dark'
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
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {} }
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
        lualine_b = {
          { 'filename', path = 1 }
        },
        lualine_c = {},
        lualine_x = { 'branch' },
        lualine_y = { 'diagnostics' },
      },
    },
  },

  { 'numToStr/Comment.nvim',           opts = {} },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<Esc><Esc>"] = "close",
            ["<C-u>"] = false,
            ['<C-d>'] = "delete_buffer",
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
        live_grep = {
          additional_args = function(_)
            return { '--hidden', '--glob', '!**/.git/*' }
          end
        },
        grep_string = {
          additional_args = function(_)
            return { '--hidden', '--glob', '!**/.git/*' }
          end
        },
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

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      enable_git_status = false,
      filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
        }
      }
    }
  },
  { "szw/vim-maximizer" },
  { "benfowler/telescope-luasnip.nvim" },
  { "mfussenegger/nvim-dap" },
  {
    "f-person/git-blame.nvim",
    opts = {
      enabled = false,
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio" }
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require 'marks'.setup {
        default_mappings = true,
        signs = true,
        mappings = {}
      }
    end
  },
}, {})

-- vim opts
vim.opt.exrc = true
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
-- spellcheck
vim.opt.spell = true
-- make copy into * clipboard by default
vim.opt.clipboard = { "unnamedplus", "unnamed" }
-- ctrl-a/x incr decr alphabet letters
vim.opt.nrformats:append("alpha")
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

if os.getenv('TMUX') and not os.getenv('WSLENV')
then
  local copyCommand = { "bash", "-c", "tmux load-buffer - | tmux save-buffer - | xclip -r -selection clipboard" }
  local pasteCommand = { "tmux", "save-buffer", "-" }
  vim.g.clipboard = {
    name = 'tmux clipboard',
    copy = {
      ["+"] = copyCommand,
      ["*"] = copyCommand
    },
    paste = {
      ["+"] = pasteCommand,
      ["*"] = pasteCommand
    },
    cache_enabled = true
  }
end
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- show space as dot when list
vim.opt.listchars:append({ space = "·" })
-- show whitespaces with error msg
vim.fn.matchadd('errorMsg', [[\s\+$]])
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- keymaps
-- nohl on double esc
vim.keymap.set({ "n" }, "<Esc><Esc>", ":let @/ = ''<CR>", { silent = true })
-- scrolling through text
vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz")
-- use ; as : very convenient as not need to hold shift
vim.keymap.set({ "n", "v", "o" }, ";", ":")
-- instead the repeat f, t command is set to ,
vim.keymap.set({ "n", "v", "o" }, ":", ";")
-- repeat back f, t command is set to leader + ,
vim.keymap.set({ "n", "v", "o" }, "<Leader>,", ",")
vim.opt.splitright = true
vim.keymap.set('n', '<leader>mx', ':MaximizerToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>u', ":<c-u>call search(\'\\u\')<CR>", { desc = 'Next [U]pper', silent = true })
-- command mode abbreviations
-- FIXME: migrate to this when version 0.10 released
-- vim.keymap.set("ca", "tn", "tabnew")
vim.cmd("ca tn tabnew")

--terminal mode exit
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", { silent = true })
-- diagnostics keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', ']o', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = '[S]earch [Q]uickfix list' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch workspace [d]iagnostics' })
vim.keymap.set('n', '<leader>q', require('telescope.builtin').diagnostics, { desc = 'Diagnostics' })

-- telescope configuration
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension 'luasnip')

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>e', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>of', function() require('telescope.builtin').oldfiles { only_cwd = true } end,
  { desc = 'Search [O]ld [F]files' })
local search_fn = function()
  require('telescope.builtin').find_files { find_command = { 'rg', '--files', '--hidden', '-g', '!.git', '-u' } }
end
vim.keymap.set('n', '<leader>sf', search_fn, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>f', search_fn, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>b', function()
  require('telescope.builtin').buffers { sort_lastused = true }
end, { desc = 'Search [B]uffers' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch [W]ord' })
vim.keymap.set('n', '<leader>rs', require('telescope.builtin').resume, { desc = '[R]esume [S]earch for previous picker' })
vim.keymap.set('n', '<leader>re', require('telescope.builtin').registers, { desc = '[R][e]gister' })
vim.keymap.set('n', '<leader>ma', require('telescope.builtin').marks, { desc = 'Show [M][A]rks' })
-- neotree maps
vim.keymap.set('n', '<leader>t', function() require('neo-tree.command').execute { toggle = true, position = 'right' } end,
  { desc = '[T]oggle NeoTree' })

-- [[ Configure Treesitter ]]
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'yaml' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',

        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {

          [']M'] = '@function.outer',
          [']['] = '@class.outer',

        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },

        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- lsp configuration

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc, silent)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = silent })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gD', ":vs | lua require('telescope.builtin').lsp_definitions()<CR>", '[G]oto [D]efinition', true)
  -- nmap('gds', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', function() return require('telescope.builtin').lsp_references { include_current_line = true } end,
    '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  gopls = {
    gopls = {
      gofumpt = true,
      symbolScope = "workspace",
    },
  },
  -- pyright = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      }
    },
  },
  golangci_lint_ls = {},
}

-- Setup neovim lua configuration
require('neodev').setup()

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
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

local ok, path = pcall(require, 'nvim-lsp-installer.path')
local gopls_cmd
if ok then
  local install_root_dir = path.concat { vim.fn.stdpath 'data', 'lsp_servers' }
  gopls_cmd = { install_root_dir .. '/go/gopls' }
end

require("go").setup({
  lsp_codelens = false,
  gopls_cmd = gopls_cmd,
  luasnip = true,
})

-- custom commands
vim.api.nvim_create_user_command('TrimWhiteSpace', "%s/\\s\\+$//e", {})
vim.api.nvim_create_user_command('FormatJSON', ":%!jq .", {})

-- call live_grep over specific filetypes
vim.api.nvim_create_user_command('LiveGrepType', function(opts)
  require('telescope.builtin').live_grep({ type_filter = opts.args })
end, { nargs = 1 })

-- I seem to have difficulty remembering :copen command
vim.api.nvim_create_user_command('QuickFix', ":copen", {})

-- TODO: Create function to call command and put results into QuickFix list
--vim.api.nvim_create_user_command('QFixCall',":cgetexpr system($1)", {})

-- grep string as command
vim.api.nvim_create_user_command('Gs', function(opts)
  require('telescope.builtin').grep_string({ search = opts.args })
end, { nargs = 1 })
vim.api.nvim_create_user_command('Ag', function(opts)
  require('telescope.builtin').grep_string({ search = opts.args })
end, { nargs = 1 })
-- autocommands
-- shows whitespaces when entering visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:[vV\x16]*",
  callback = function()
    vim.opt.list = true
    vim.opt.relativenumber = true
  end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "[vV\x16]*:*",
  callback = function()
    vim.opt.list = false
    vim.opt.relativenumber = false
  end,
})

--  associate yaml templates
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.yaml.tpl",
  command = "set filetype=yaml"
})

-- Run gofmt on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport() -- goimport + gofmt
  end,
  group = format_sync_grp,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 600, on_visual = false })
  end,
  group = highlight_group,
  pattern = '*',
})
--
-- [[ Configure nvim-cmp ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert {

    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},

    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
