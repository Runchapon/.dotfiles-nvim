local wk = require("which-key")
wk.add({
  { "gR", "<cmd>Telescope lsp_references<CR>",               desc = "Show LSP references" },
  { "gD", vim.lsp.buf.declaration,                           desc = "Go to declaration" },
  { "gd", "<cmd>Telescope lsp_definitions<CR>",              desc = "Show LSP definitions" },
  { "gi", "<cmd>Telescope lsp_implementations<CR>",          desc = "Show LSP implementations" },
  { "gt", "<cmd>Telescope lsp_type_definitions<CR>",         desc = "Show LSP type definitions" },
  { "[d", vim.diagnostic.jump({ count = -1, float = true }), desc = "Go to previous diagnostic" },
  { "]d", vim.diagnostic.jump({ count = 1, float = true }),  desc = "Go to next diagnostic" },
  {
    "K",
    vim.lsp.buf.hover,
    desc = "Show documentation for what is under cursor",
  },
  { "<leader>rs", ":LspRestart<CR>",                        desc = "Restart LSP" },
  { "<leader>rn", vim.lsp.buf.rename,                       desc = "Smart rename" },
  { "<leader>D",  "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Show buffer diagnostics" },
  { "<leader>d",  vim.diagnostic.open_float,                desc = "Show line diagnostics" },
  { mode = "n" },
  {
    "<leader>ca",
    vim.lsp.buf.code_action,
    desc = "See available code actions",
    mode = { "n", "v" },
  },
})
