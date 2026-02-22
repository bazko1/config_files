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

      local utils = require 'gitblame.utils'
      local remote_name = 'upstream'
      local set_remote_if_defined = function()
        local remote_url_command = utils.make_local_command('git remote get-url ' .. remote_name)
        utils.start_job(remote_url_command, {
          on_stdout = function(url)
            if url and url[1] ~= '' then
              vim.g.gitblame_remote_name = remote_name
            else
            end
          end,
        })
      end

      -- change remote name to upstream on certain repos
      local root_repos_path = vim.fn.expand '~' .. '/gitworkspace'
      local set_remote_name = function()
        for _, repo in ipairs(upstream_repos) do
          local repo_path = vim.fs.abspath(vim.fs.joinpath(root_repos_path, repo))
          local cwd = vim.fn.getcwd()
          if vim.startswith(cwd, repo_path) then
            set_remote_if_defined()
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
