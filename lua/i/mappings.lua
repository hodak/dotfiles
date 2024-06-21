-- normal
vim.api.nvim_set_keymap("n", "'", ";", { noremap = true, silent = false }) -- ' instead of ;
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = false }) -- ; instead of : - :w -> ;w. saves milliseconds on each operation
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
