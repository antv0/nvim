local default = {
  on_attach = function(client, bufnr)
    require "lsp_signature".on_attach(
    {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "none"
      },
      hint_enable = false,
      doc_lines = 0,
      floating_window_off_x = 999,
      floating_window_off_y = 1,
      -- floating_window = false,
    }
    , bufnr) -- Note: add in lsp client on-attach
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
}

local servers = {
  java_language_server = { cmd = {"java-language-server"} },
  ocamllsp = {},
  pyright = {},
  basedpyright = {},
  lua_ls = {},
  clangd = {},
  ccls = {},
  -- jedi_language_server = {},
  nixd = {},
  ltex = {
    settings = {
      ltex = {
        language = "fr",
      },
    },
  },
  elixirls = {
    cmd = { "elixir-ls" },
  },
  rust_analyzer = {},
  glslls = {
    cmd = { "glslls", "--target-env", "opengl", "--stdin" },
  },
}

local enabled = {}

for server, config in pairs(servers) do
  local lsp = require("lspconfig")[server]
    
  -- print(server)
  local config = vim.tbl_deep_extend("keep", config, default, lsp.document_config.default_config)
  if config.cmd ~= nil then
    if vim.fn.executable(config.cmd[1]) == 1 then
      table.insert(enabled, server)
    end
  end
end

-- disable pyright if besedpyright is enabled
for _, server in pairs(enabled) do
  if server == "basedpyright" then
    for i, s in ipairs(enabled) do
      if s == "pyright" then
        table.remove(enabled, i)
        break
      end
    end
  end
end

for _, server in pairs(enabled) do
  local lsp = require("lspconfig")[server]
  local config = servers[server]
  lsp.setup(config)
end


vim.diagnostic.config({
  virtual_text = false,
  -- signs = true,
  -- underline = true,
  -- update_in_insert = false,
  -- severity_sort = false,
})
