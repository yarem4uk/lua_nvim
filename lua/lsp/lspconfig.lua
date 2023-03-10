local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

local mason_null_ls_ok, mason_null_ls = pcall(require, 'mason-null-ls')
if not mason_null_ls_ok then
  return
end

local servers = {
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  jsonls = {},
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
    },
  },
}

mason.setup()

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({

      capabilities = require('lsp.handlers').capabilities,
      on_attach = require('lsp.handlers').on_attach,
      settings = servers[server_name],
    })
  end,
})

mason_null_ls.setup({
  ensure_installed = {
    'prettier',
    'eslint_d',
    'stylelua',
    'flake8',
    'black',
  },
})
