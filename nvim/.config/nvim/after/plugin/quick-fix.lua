require("which-key").add({
	{ ";q", group = "QuickFix" },
	{ ";qq", "<cmd>BqfAutoToggle<CR>", desc = "Toggle Auto Quick Fix" },
	{ ";qo", "<cmd>copen<CR>", desc = "Open Quick Fix" },
	{ ";qc", "<cmd>cclose<CR>", desc = "Close Quick Fix" },
	{ ";qn", "<cmd>cnext<cr>", desc = "Next Quick Fix" },
	{ ";qp", "<cmd>cprevious", desc = "Previous Quick Fix" },
})
