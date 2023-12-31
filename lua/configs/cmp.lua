local cmp = require "cmp"

local options = {

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = function(callback)
      callback()
    end,
    ["<S-Tab>"] = function(callback)
      callback()
    end,
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    -- { name = 'nvim_lsp_signature_help' },
    { name = "nvim_lsp_document_symbol" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

return options
