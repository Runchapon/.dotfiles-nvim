local M = {
	"mfussenegger/nvim-lint",
	event = "LspAttach",
}
M.config = function()
	local lint = require("lint")

	lint.linters_by_ft = {
		javascript = { "sonarlint-language-server" },
		typescript = { "sonarlint-language-server" },
		python = { "pylint" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
