local M = { "nvim-mini/mini.files", version = "*" }

function M.config()
	require("mini.files").setup()
end

return M
