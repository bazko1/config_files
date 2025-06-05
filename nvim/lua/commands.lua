-- custom commands
vim.api.nvim_create_user_command('TrimWhiteSpace', '%s/\\s\\+$//e', {})
vim.api.nvim_create_user_command('FormatJSON', ':%!jq .', {})
vim.api.nvim_create_user_command('Python3', ':vs | term python3', {})

-- call live_grep over specific filetypes
vim.api.nvim_create_user_command('LiveGrepType', function(opts)
  require('telescope.builtin').live_grep { type_filter = opts.args }
end, { nargs = 1 })
