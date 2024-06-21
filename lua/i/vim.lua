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

-- disable backup and swap files
vim.opt.backup = false
vim.opt.swapfile = false

-- always use system clipbboard
-- * https://stackoverflow.com/a/10979533/1023664
vim.opt.clipboard = "unnamed"

-- keep undo history across sessions by storing it in a file
-- * https://www.reddit.com/r/vim/comments/714dfj/comment/dn888ze
vim.opt.undofile = true

-- https://neovim.discourse.group/t/git-diff-highlighting-are-not-working-anymore-in-gitcommit-filetype/3547/5
vim.cmd [[
  highlight def link @text.diff.add DiffAdded
  highlight def link @text.diff.delete DiffRemoved
]]
