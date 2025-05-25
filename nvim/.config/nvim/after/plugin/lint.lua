require("which-key").add({
	{
		"<leader>tl",
		function()
			require("lint").try_lint()
		end,
		desc = "Trigger linting for current file",
	},
})
