require("which-key").add({
  { "<Tab>",      ":bn<cr>",                     { desc = "Buffer Next" } },
  { "<S-Tab>",    ":bp<cr>",                     { desc = "Buffer Previous" } },
  { "<leader>bD", "<cmd>BufferLinePickClose<cr>", { desc = "Buffer Pick Delete" } },
  { "<leader>bd", function()
    local buf = vim.inspect(vim.api.nvim_get_current_buf())
    local cmd = string.format( "bp|sp|bn|bd! %d", buf)
    vim.cmd(cmd)
  end,
    { desc = "Buffer Delete Current" } }
})
