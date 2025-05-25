local wk = require("which-key")

wk.add({
	{ "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
	{ "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" },
})
