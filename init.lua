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
  -- Theme
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").load()
    end
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
        lualine_x = {},
        lualine_y = {'diagnostics'},
      },
    },
  },

  { 'numToStr/Comment.nvim', opts = {} },

},{})

-- vim opts

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.expandtab = true -- expand tabs
vim.opt.smartindent = true -- indents smart
-- enable 24-but rgb color in the TUI
vim.opt.termguicolors = true
-- line wrapping
vim.opt.wrap = false -- do not use linewrap by default
vim.opt.linebreak = false -- do not break by words at the end of the line

-- Disable swap files
vim.opt.swapfile = false
vim.opt.spell = false
vim.opt.number = true
-- make copy into * clipboard by default
vim.opt.clipboard = unnamedplus

-- keymaps
-- nohl on double esc
vim.keymap.set({ "n","v" },"<Esc><Esc>", ":let @/ = ''<CR>", { silent = true })
-- use ; as : very convenient as not need to hold shift
vim.keymap.set({ "n","v","o" }, ";", ":")
-- instead the repeat f, t command is set to ,
vim.keymap.set({"n","v","o"}, ",", ";")
-- repeat back f, t command is set to leader + ,
vim.keymap.set({"n","v","o"}, "<Leader>,", ",")
