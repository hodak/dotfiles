print("👋 Hello to Neovim")

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

-- MAPPINGS
-- normal
vim.api.nvim_set_keymap("n", "<leader><leader>", "<C-^>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xml", ":%!xmllint --format -<ENTER>", { noremap = true })
-- insert
-- * http://newbiedoc.sourceforge.net/tutorials/vim/mapping-vim.html.en
vim.api.nvim_set_keymap("i", ",cl", "console.log()<esc>i", { noremap = true })
vim.api.nvim_set_keymap("i", ",cg", "console.group('')<return>console.log()<return>console.groupEnd()<esc>kkhi", { noremap = true })
vim.api.nvim_set_keymap("i", ",ip", "IO.puts<space>", { noremap = true })
vim.api.nvim_set_keymap("i", ",ii", "IO.inspect<space>", { noremap = true })
vim.api.nvim_set_keymap("n", ",iI", "o|> IO.inspect<esc>", { noremap = true })

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = '*.ex,*.exs' })

require('packer').startup(function(use)
  use('wbthomason/packer.nvim') -- Packer can manage itself

  use('ctrlpvim/ctrlp.vim')
  use('mileszs/ack.vim')
  use('alexghergh/nvim-tmux-navigation')
  use({'nvim-tree/nvim-tree.lua'})

  use('tpope/vim-commentary')
  use('tpope/vim-endwise')
  use('tpope/vim-fugitive')

  use('flazz/vim-colorschemes')

  use('elixir-editors/vim-elixir')

  -- language server, completion
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/vim-vsnip')
  use('hrsh7th/cmp-vsnip')
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

-- nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  renderer = {
    icons = { show = { file = false, folder = false, folder_arrow = false, git = false } }
  }
})
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<enter>', { noremap = true })

-- vim-colorschemes
vim.cmd [[
  colorscheme Tomorrow-Night " dark
  " colorscheme github " light (outdoor)
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
-- TIP: check your logs and the output of :LspInfo. Add the following to your init.vim to enable logging: `vim.lsp.set_log_level("debug")`
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
end

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.ex,*.exs', command = 'lua vim.lsp.buf.format({ async = false })' })

require('lspconfig').elixirls.setup {
  cmd = { "/Users/adam/elixir-ls/language_server.sh" },
  on_attach = on_attach,
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- for vsnip users.
    { name = 'buffer' }
  })
})
