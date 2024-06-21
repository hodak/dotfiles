-- elixir-tools
require('elixir').setup({
  elixirls = {
    enable = true,
    -- tail -f ~/.local/state/nvim/lsp.log
    cmd = '/Users/adam/elixir-ls/language_server.sh',
  },
  nextls = {
    enable = false,
    init_options = {
      experimental = {
        completions = { enable = true }
      }
    }
  },
  credo = { enable = true },
})

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.ex,*.exs', command = 'lua vim.lsp.buf.format({ async = false })' })

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd> lua vim.lsp.buf.format()<CR>', { noremap = true })
