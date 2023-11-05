vim.opt.termguicolors = true

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
