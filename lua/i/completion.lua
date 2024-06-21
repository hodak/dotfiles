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
