-- nvim-treesitter
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
