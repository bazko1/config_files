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

      vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = '[G]it [B]lame', silent = true })

      local upstream_repos = {
        'minio',
        'git-blame.nvim',
      }
      -- change remote name to upstream on certain repos
      local root_repos_path = vim.fn.expand '~' .. '/gitworkspace'
      local set_remote_name = function()
        for _, repo in ipairs(upstream_repos) do
          local repo_path = vim.fs.abspath(vim.fs.joinpath(root_repos_path, repo))
          if vim.startswith(vim.fn.getcwd(), repo_path) then
            vim.g.gitblame_remote_name = 'upstream'
          end
        end
      end

      vim.api.nvim_create_autocmd({ 'DirChanged' }, {
        callback = set_remote_name,
      })

      -- call once on init
      set_remote_name()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
