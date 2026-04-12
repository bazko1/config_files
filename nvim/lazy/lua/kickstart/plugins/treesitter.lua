return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      -- ensure basic parser are installed
      local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go', 'rust' }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, 'indent') ~= nil

        -- enables treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      }
      vim.keymap.set('n', '<leader>a', function()
        require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
      end)
      vim.keymap.set('n', '<leader>A', function()
        require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner'
      end)

      local keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',

        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      }

      for keymap, textobj in pairs(keymaps) do
        vim.keymap.set({ 'x', 'o' }, keymap, function()
          require('nvim-treesitter-textobjects.select').select_textobject(textobj, 'textobjects')
        end)
      end

      local moves = {
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
          [']f'] = '@loop.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
          ['[f'] = '@loop.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      }
      for fn, maps in pairs(moves) do
        for keymap, textobj in pairs(maps) do
          vim.keymap.set({ 'n', 'x', 'o' }, keymap, function()
            require('nvim-treesitter-textobjects.move')[fn](textobj, 'textobjects')
          end)
        end
      end
    end,
  },
}

--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     dependencies = {
--       'nvim-treesitter/nvim-treesitter-textobjects',
--     },
--     build = ':TSUpdate',
--     main = 'nvim-treesitter.configs', -- Sets main module to use for opts
--     opts = {
--       ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' },
--       -- Autoinstall languages that are not installed
--       auto_install = true,
--       highlight = {
--         enable = true,
--         -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--         --  If you are experiencing weird indenting issues, add the language to
--         --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--         additional_vim_regex_highlighting = { 'ruby' },
--       },
--       indent = { enable = true, disable = { 'ruby' } },
--       incremental_selection = {
--         enable = true,
--         keymaps = {
--           init_selection = '<c-space>',
--           node_incremental = '<c-space>',
--           scope_incremental = '<c-s>',
--
--           node_decremental = '<M-space>',
--         },
--       },
--       textobjects = {
--         select = {
--           enable = true,
--           lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--           keymaps = {
--             -- You can use the capture groups defined in textobjects.scm
--             ['aa'] = '@parameter.outer',
--             ['ia'] = '@parameter.inner',
--             ['af'] = '@function.outer',
--             ['if'] = '@function.inner',
--             ['ac'] = '@class.outer',
--             ['ic'] = '@class.inner',
--
--             ['al'] = '@loop.outer',
--             ['il'] = '@loop.inner',
--           },
--         },
--         move = {
--           enable = true,
--           set_jumps = true, -- whether to set jumps in the jumplist
--           goto_next_start = {
--             [']m'] = '@function.outer',
--             [']]'] = '@class.outer',
--             [']f'] = '@loop.outer',
--           },
--           goto_next_end = {
--             [']M'] = '@function.outer',
--             [']['] = '@class.outer',
--           },
--           goto_previous_start = {
--             ['[m'] = '@function.outer',
--             ['[['] = '@class.outer',
--             ['[f'] = '@loop.outer',
--           },
--           goto_previous_end = {
--             ['[M'] = '@function.outer',
--             ['[]'] = '@class.outer',
--           },
--         },
--         swap = {
--           enable = true,
--           swap_next = {
--             ['<leader>a'] = '@parameter.inner',
--           },
--           swap_previous = {
--             ['<leader>A'] = '@parameter.inner',
--           },
--         },
--       },
--     },
--     -- There are additional nvim-treesitter modules that you can use to interact
--     -- with nvim-treesitter. You should go explore a few and see what interests you:
--     --
--     --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--     --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--     --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--   },
-- }

-- vim: ts=2 sts=2 sw=2 et
