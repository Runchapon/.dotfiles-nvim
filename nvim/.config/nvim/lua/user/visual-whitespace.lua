local M = {
	"mcauley-penney/visual-whitespace.nvim",
	event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
}

function M.config()
	require("visual-whitespace").setup({
		enabled = true,
		highlight = { link = "Visual", default = true },
		match_types = {
			space = true,
			tab = true,
			nbsp = true,
			lead = false,
			trail = false,
		},
		list_chars = {
			space = "·",
			tab = "↦",
			nbsp = "␣",
			lead = "‹",
			trail = "›",
		},
		fileformat_chars = {
			unix = "↲",
			mac = "←",
			dos = "↙",
		},
		ignore = { filetypes = {}, buftypes = {} },
	})
end

return M
