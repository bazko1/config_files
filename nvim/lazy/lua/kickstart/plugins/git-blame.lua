return {
  {
    'f-person/git-blame.nvim',
    branch = 'main',
    opts = {
      enabled = false,
      date_format = '%r | %m-%d-%Y ',
    },
    config = function(_, opts)
      require('gitblame').setup(opts)

      vim.keymap.set('n', '<leader>gb', ':GitBlameEnable<CR>', { desc = '[G]it [B]lame', silent = true })

      -- change remote name to upstream on certain repos
      local upstream_repos = {
        'minio',
        'git-blame.nvim',
      }
      local root_repos_path = vim.fn.expand '~' .. '/gitworkspace'
      vim.api.nvim_create_autocmd({ 'DirChanged' }, {
        callback = function()
          for _, repo in ipairs(upstream_repos) do
            local repo_path = vim.fs.abspath(vim.fs.joinpath(root_repos_path, repo))
            if vim.startswith(vim.fn.getcwd(), repo_path) then
              vim.g.gitblame_remote_name = 'upstream'
            end
          end
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
