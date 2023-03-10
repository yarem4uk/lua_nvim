local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {

  -- js
  formatting.prettier,
  diagnostics.eslint_d,

  -- python
  formatting.black.with({
    extra_args = { '--fast', '-l', 79, '--skip-string-normalization' },
  }),
  diagnostics.flake8,

  -- lua
  formatting.stylua.with({
    extra_args = {
      '--indent-type',
      'Spaces',
      '--indent-width',
      2,
      '--quote-style',
      'AutoPreferSingle',
      '--line-endings',
      'Unix',
    },
  }),
}

null_ls.setup({
  debug = false,
  sources = sources,
  -- on_attach = function(current_client, bufnr)
  --   if current_client.supports_method('textDocument/formatting') then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd('BufWritePre', {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format({
  --           filter = function(client)
  --             --  only use null-ls for formatting instead of lsp server
  --             return client.name == 'null-ls'
  --           end,
  --           bufnr = bufnr,
  --         })
  --       end,
  --     })
  --   end
  -- end,
})
