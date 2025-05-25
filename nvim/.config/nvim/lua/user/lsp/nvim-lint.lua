local lint = require("lint")
require("whick-key").add({
	{
		"<leader>tl",
		function()
			lint.try_lint()
		end,
		desc = "Trigger linting for current file",
	},
})
