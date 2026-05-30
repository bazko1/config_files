return {
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'theHamsta/nvim-dap-virtual-text',
    },
    opts = {
      lsp_keymaps = false,
      luasnip = true,
      lsp_codelens = false,
      virtual_text = false,
      lsp_gofumpt = true,
      gofmt = 'gofumpt',
      goimports = 'gofmt',
      lsp_cfg = { settings = { gopls = { analyses = { ST1000 = false }, staticcheck = false } } },
      lsp_inlay_hints = { enable = true },
      golangci_lint = {
        default = 'fast',
      },
    },
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function(_, opts)
      require('go').setup(opts)
      -- disable inlay hints by default
      vim.lsp.inlay_hint.enable(false)
      local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
