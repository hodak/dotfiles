-- elixir-tools

local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup({
  elixirls = {
    enable = true,
    -- tail -f ~/.local/state/nvim/lsp.log
    cmd = '/Users/adam/elixir-ls/language_server.sh',
    -- default settings, use the `settings` function to override settings
    settings = elixirls.settings {
      dialyzerEnabled = true,
      fetchDeps = true,
      enableTestLenses = true,
      suggestSpecs = true,
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
    end
  },
  nextls = {
    enable = false,
    init_options = {
      experimental = {
        completions = { enable = true }
      }
    }
  },
  credo = { enable = false },
})

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.ex,*.exs', command = 'lua vim.lsp.buf.format({ async = false })' })

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd> lua vim.lsp.buf.format()<CR>', { noremap = true })
