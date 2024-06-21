 -- print("👋 Hello to Neovim")

-- * https://arusahni.net/blog/2020/08/elixir-vim.html
-- * https://www.adrian.idv.hk/2022-05-07-nvim-lua/
-- * https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- * https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- * https://elixirforum.com/t/neovim-elixir-setup-configuration-from-scratch-guide/46310
-- * https://www.youtube.com/watch?v=w7i4amO_zaE
-- * https://gist.github.com/celso/6cefedb9fce92827ee38e8f7411b8b30

vim.g.mapleader = "," -- change the mapleader from \ to ,

require('i.vim')
require('i.mappings')
require('i.plugins')
require('i.ctrlp')
require('i.ack')
require('i.nvim-tmux-navigation')
require('i.nerdtree')
require('i.vim-colorschemes')
require('i.vim-vroom')
require('i.nvim-treesitter')
require('i.completion')
require('i.elixir')
require('i.prettier')
