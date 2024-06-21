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

vim.cmd [[
  nnoremap <silent> <C-h> <Cmd>NvimTmuxNavigateLeft<CR>
  nnoremap <silent> <C-j> <Cmd>NvimTmuxNavigateDown<CR>
  nnoremap <silent> <C-k> <Cmd>NvimTmuxNavigateUp<CR>
  nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR>
  nnoremap <silent> <C-\> <Cmd>NvimTmuxNavigateLastActive<CR>
  nnoremap <silent> <C-Space> <Cmd>NvimTmuxNavigateNext<CR>
]]
