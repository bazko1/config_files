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
      virtual_text = false,
      gofmt = 'gofumpt',
      lsp_gofumpt = true,
      lsp_cfg = true,
      lsp_inlay_hints = { enable = true },
    },
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function(_, opts)
      require('go').setup(opts)
      -- disable inlay hints by default
      vim.lsp.inlay_hint.enable(false)
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
