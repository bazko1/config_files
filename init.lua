-- Disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- enable 24-but rgb color in the TUI
vim.opt.termguicolors = true

-- packer plugins configuration
-- Install packer if it's not already installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = true
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim opts
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- tabs & indentation
vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.softtabstop = 4 -- 4 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 4 spaces for indent width
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.expandtab = true -- expand tabs
vim.opt.smartindent = true -- indents smart

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
vim.keymap.set({ 'n','v' },'<Esc><Esc>', ':let @/ = ""<CR>', { silent = true })
-- use ; as : very convenient as not need to hold shift
vim.keymap.set({ 'n','v','o' }, ';', ':')
-- instead the repeat f, t command is set to ,
vim.keymap.set({'n','v','o'}, ',', ';')
-- repeat back f, t command is set to leader + ,
vim.keymap.set({'n','v','o'}, '<Leader>,', ',')
