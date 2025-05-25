-- UNUSED
local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  local formatting = null_ls.builtins.formatting
  -- local diagnostics =  null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      formatting.gofumpt,
      formatting.goimports_reviser,
      formatting.golines,
      null_ls.builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = augroup,
          buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })
end

return M
