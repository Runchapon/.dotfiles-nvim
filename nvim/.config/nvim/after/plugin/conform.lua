local wk = require("which-key")
local conform = require("conform")
wk.add({
	{
		"<leader>fm",
		function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end,
		desc = "Format file or range (in visual mode)",
	},
	{ mode = { "n", "v" } },
})
