return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    config = function()
      require('oil').setup {
        keymaps = {
          ['g\\'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n', nowait = true },
        },
      }
      vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}

-- vim: ts=2 sts=2 sw=2 et
