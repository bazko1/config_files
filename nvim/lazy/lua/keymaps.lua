-- use ; as : very convenient as not need to hold shift
vim.keymap.set({ 'n', 'v', 'o' }, ';', ':')
-- instead the repeat f, t command is set to ,
vim.keymap.set({ 'n', 'v', 'o' }, ':', ';')

-- Clear highlights on search when pressing 2*<Esc> in normal mode
vim.keymap.set({ 'n' }, '<Esc><Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', ']o', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- terminal
vim.keymap.set('t', '<C-space>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- shortcuts
vim.keymap.set('ca', 'tn', 'tabnew')

-- change split sizes as arrows
vim.keymap.set('n', '<left>', '<C-W>5<')
vim.keymap.set('n', '<right>', '<C-W>5>')
vim.keymap.set('n', '<up>', '<C-W>5-')
vim.keymap.set('n', '<down>', '<C-W>5+')
--
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 500, on_visual = false }
  end,
})

-- shows whitespaces when entering visual-line mode
-- NOTE: If added extra 'v' to the pattern the visual will also include change
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*:[V\22]*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      return
    end
    vim.opt.list = true
    vim.opt.relativenumber = true
  end,
})
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '[V\22]*:*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      return
    end
    vim.opt.list = false
    vim.opt.relativenumber = false
  end,
})

if vim.g.neovide then
  vim.keymap.set({ 'n', 'v' }, '<C-+>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end

-- vim: ts=2 sts=2 sw=2 et
