return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.cmd 'colorscheme catppuccin-mocha'
    end,
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      -- require('onedark').setup {
      --   style = 'deep',
      --   transparent = true,
      -- }
      -- require('onedark').load()
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
