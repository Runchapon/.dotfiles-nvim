local M = {
  "xiyaowong/transparent.nvim",
}

function M.config()
  local transparent = require("transparent")
  transparent.setup({
    extra_groups = {
      "LspInlayHint",
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePromptNormal",
      "TelescopePromptBorder",
      "TelescopePromptTitle",
      "TelescopeResultsTitle",
      "TelescopePreviewTitle",
      "TelescopePreviewLine",
      "TabLineFill",
    },
  })
end

return M
