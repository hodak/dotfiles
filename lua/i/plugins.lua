return require('packer').startup(function(use)
  use('wbthomason/packer.nvim') -- Packer can manage itself

  use('ctrlpvim/ctrlp.vim')
  use('mileszs/ack.vim')
  use('alexghergh/nvim-tmux-navigation')
  use('preservim/nerdtree')

  use('tpope/vim-commentary')
  use('tpope/vim-endwise')
  use('tpope/vim-fugitive')

  use('flazz/vim-colorschemes')
  use('sainnhe/everforest')

  use({'skalnik/vim-vroom', requires = {'preservim/vimux'}})

  use({'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  })

  use('elixir-editors/vim-elixir')

  use({"zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      -- :PackerCompile
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-p>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            -- accept = false,
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  })
  -- Super-Tab https://github.com/zbirenbaum/copilot.lua/discussions/153#discussioncomment-5701223
  -- unfortunately, it doesn't work too well with cmp
  vim.keymap.set('i', '<Tab>', function()
    if require("copilot.suggestion").is_visible() then
      require("copilot.suggestion").accept_line()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    end
  end, { desc = "Super Tab" })

  -- language server, completion
  use({'elixir-tools/elixir-tools.nvim',
    tag = 'stable',
    requires = { 'nvim-lua/plenary.nvim' }
  })

  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/vim-vsnip')
  use('hrsh7th/cmp-vsnip')
  use({"zbirenbaum/copilot-cmp",
    after = {"copilot.lua"},
    config = function ()
      require("copilot_cmp").setup()
    end
  })

  use({'prettier/vim-prettier',
    branch = 'master',
    run = 'npm install',
  })

  -- projectionist
  use('tpope/vim-projectionist')
  use('c-brenn/fuzzy-projectionist.vim')
  use('andyl/vim-projectionist-elixir')
end)
