local M = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "markdownlint" },
			graphql = { "prettier" },
			liquid = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
		},
		-- uncomment this if want to use format on save
		-- format_on_save = {
		-- 	lsp_fallback = true,
		-- 	async = false,
		-- 	timeout_ms = 1000,
		-- },
	})

end

return M
