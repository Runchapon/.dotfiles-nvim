local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				keys = { "f", "F", "t", "T" },
			},
		},
	},
	-- stylua: ignore
	keys = {
	  { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	  { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	  { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}

return M
