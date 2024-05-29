 -- print("👋 Hello to Neovim")

-- * https://arusahni.net/blog/2020/08/elixir-vim.html
-- * https://www.adrian.idv.hk/2022-05-07-nvim-lua/
-- * https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- * https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- * https://elixirforum.com/t/neovim-elixir-setup-configuration-from-scratch-guide/46310
-- * https://www.youtube.com/watch?v=w7i4amO_zaE
-- * https://gist.github.com/celso/6cefedb9fce92827ee38e8f7411b8b30

vim.opt.number = true -- show lines
vim.opt.relativenumber = true -- relative numbers, easy jumping
-- TABBING
vim.opt.expandtab = true -- expand TABs to spaces
vim.opt.softtabstop = 2 -- sets the number of columns for a TAB
vim.opt.shiftwidth = 2 -- indents will have a width of 4
vim.opt.tabstop = 2

vim.opt.hlsearch = false -- stop highlighting for the 'hlsearch' option
vim.opt.splitright = true -- split vertically to the right
vim.opt.ic = true -- ignore case while search
vim.opt.colorcolumn = "98"

vim.g.mapleader = "," -- change the mapleader from \ to ,
vim.api.nvim_set_keymap("n", "'", ";", { noremap = true, silent = false }) -- ' instead of ;
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = false }) -- ; instead of : - :w -> ;w. saves milliseconds on each operation

-- always use system clipbboard
-- * https://stackoverflow.com/a/10979533/1023664
vim.opt.clipboard = "unnamed"

-- keep undo history across sessions by storing it in a file
-- * https://www.reddit.com/r/vim/comments/714dfj/comment/dn888ze
vim.opt.undofile = true

-- disable backup and swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- MAPPINGS
-- normal
vim.api.nvim_set_keymap("n", "<leader><leader>", "<C-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xml", ":%!xmllint --format -<ENTER>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>9", ":tabp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":tabn<CR>", { noremap = true })
vim.cmd [[
  cnoreabbrev vt tab split
]]
-- insert
-- * http://newbiedoc.sourceforge.net/tutorials/vim/mapping-vim.html.en
vim.api.nvim_set_keymap("i", ",cl", "console.log()<esc>i", { noremap = true })
vim.api.nvim_set_keymap("i", ",cg", "console.group('')<return>console.log()<return>console.groupEnd()<esc>kkhi", { noremap = true })
vim.api.nvim_set_keymap("i", ",ip", "IO.puts<space>", { noremap = true })
vim.api.nvim_set_keymap("i", ",ii", "IO.inspect<space>", { noremap = true })
vim.api.nvim_set_keymap("n", ",iI", "o|> IO.inspect<esc>", { noremap = true })
-- <A-o>
vim.api.nvim_set_keymap("n", "ó", ":tabp<CR>", { noremap = true })
-- <A-p>
vim.api.nvim_set_keymap("n", "Ļ", ":tabn<CR>", { noremap = true })

require('packer').startup(function(use)
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
  use({'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  })

  use('elixir-editors/vim-elixir')

  use({'skalnik/vim-vroom', requires = {'preservim/vimux'}})

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
  -- tail -f ~/.local/state/nvim/lsp.log
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('neovim/nvim-lspconfig')
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

-- ctrlp.vim
vim.cmd [[
  let g:ctrlp_user_command    = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_use_caching     = 0
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
  let g:ctrlp_map = '<leader>p'
  let g:ctrlp_cmd = 'CtrlP'
]]

-- ack
vim.cmd [[
  let g:ackprg = 'ag --vimgrep -i'
]]

-- nvim-tmux-navigation
require('nvim-tmux-navigation').setup({
  disable_when_zoomed = false,
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>",
    -- last_active = "<C-\\>",
    -- next = "<C-Space>",
  }
})

vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<enter>', { noremap = true })

-- vim-colorschemes
vim.cmd [[
  if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  set background=dark

  let g:everforest_background='hard'
  let g:everforest_better_performance=1
  let g:everforest_transparent_background=0
  let g:everforest_colors_override = {'bg0': ['#242424', '234']}

  " colorscheme everforest

  colorscheme Tomorrow-Night " dark
  " colorscheme github " light (outdoor)
]]

-- vim-vroom
vim.cmd [[
  let g:vroom_use_vimux = 1
  let g:VimuxOrientation = "v"
  let g:VimuxHeight = "40"
  if filereadable("bin/rspec")
    let g:vroom_spec_command = './bin/rspec --format=documentation'
  else
    let g:vroom_spec_command = 'rspec --format=documentation'
  endif
  let g:vroom_mix_test_command = 'elixir --sname mixtest -S mix test --color'
  let g:vroom_map_keys = 0
  map <leader>e :w\|:VroomRunNearestTest<cr>
  map <leader>r :w\|:VroomRunTestFile<cr>
]]

-- nvim-tmux-navigator
vim.cmd [[
  nnoremap <silent> <C-h> <Cmd>NvimTmuxNavigateLeft<CR>
  nnoremap <silent> <C-j> <Cmd>NvimTmuxNavigateDown<CR>
  nnoremap <silent> <C-k> <Cmd>NvimTmuxNavigateUp<CR>
  nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR>
  nnoremap <silent> <C-\> <Cmd>NvimTmuxNavigateLastActive<CR>
  nnoremap <silent> <C-Space> <Cmd>NvimTmuxNavigateNext<CR>
]]

-- nvim-lspconfig
-- TIP: check your logs and the output of :LspInfo.
-- Add the following to your init.vim to enable logging:
-- vim.lsp.set_log_level("debug")
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=false }
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({ async = false })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dgr', '<cmd>lua vim.diagnostic.reset()<CR>', opts)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- disable virtual text
      virtual_text = false,

      -- show signs
      signs = true,

      -- delay update diagnostics
      update_in_insert = false,
    }
  )
end

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.ex,*.exs', command = 'lua vim.lsp.buf.format({ async = false })' })
-- https://github.com/elixir-editors/vim-elixir/issues/562#issuecomment-1092331491
-- vim.cmd [[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]]

require('mason').setup()
local lspconfig = require("lspconfig")
-- lspconfig.elixirls.setup {
--   root_dir = function(fname)
--     return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
--   end,
--   filetypes = {"elixir", "eelixir", "heex", "surface"},
--   -- https://github.com/elixir-lsp/elixir-ls#building-and-running
--   -- cmd = { "/Users/adam/elixir-ls/_build/language_server.sh" },
--   -- cmd = { "/Users/adam/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
--   on_attach = on_attach,
--   capabilities = require('cmp_nvim_lsp').default_capabilities(),
  
-- }
lspconfig.nextls.setup({
  cmd = {"nextls", "--stdio"},
  init_options = {
    extensions = {
      credo = { enable = true }
    },
    experimental = {
      completions = { enable = true }
    }
  }
})
lspconfig.tsserver.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
-- cmp, vsnip (complete, snippets)
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- snippet agent for vsnip
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- https://github.com/hrsh7th/nvim-cmp/issues/1509#issuecomment-1492724221
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   local suggestion = require("copilot.suggestion")
    --   if suggestion.is_visible() then
    --     suggestion.accept()
    --   elseif cmp.visible() then
    --     cmp.confirm({ select = true })
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "c" }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- for vsnip users.
    { name = 'buffer' }
  })
})

vim.cmd [[
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
]]

-- https://neovim.discourse.group/t/git-diff-highlighting-are-not-working-anymore-in-gitcommit-filetype/3547/5
vim.cmd [[
  highlight def link @text.diff.add DiffAdded
  highlight def link @text.diff.delete DiffRemoved
]]

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c", "lua",
    "vim", "vimdoc", "query",
    "html", "javascript",
    "gitcommit", "diff", "git_rebase",
    "elixir", "eex", "heex", "erlang", "surface"
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
}
