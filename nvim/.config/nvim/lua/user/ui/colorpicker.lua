local M = {
	"uga-rosa/ccc.nvim",
}

function M.config()
	local ccc = require("ccc")
	-- lomkocal mapping = ccc.mapping

	ccc.setup({
		-- Your preferred settings
		-- Example: enable highlighter
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	})
end

return M
