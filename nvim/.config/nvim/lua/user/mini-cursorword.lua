local M = { "nvim-mini/mini.cursorword", version = "*" }

function M.config()
	require("mini.cursorword").setup()
end

return M
