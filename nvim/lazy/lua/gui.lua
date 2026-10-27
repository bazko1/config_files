-- gui clients configuration

if vim.g.neovide then
  vim.keymap.set({ 'n', 'v' }, '<C-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C--', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')

  local function paste()
    vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
  end
  vim.keymap.set({ 'n', 'i', 'v', 'c', 't' }, '<S-C-v>', paste, { silent = true, desc = 'Paste' })

  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_progress_bar_enabled = false
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00

  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.5
  vim.o.guifont = 'CaskaydiaCove Nerd Font:h14'
end

-- vim: ts=2 sts=2 sw=2 et
