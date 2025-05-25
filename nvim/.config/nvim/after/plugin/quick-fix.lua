require("which-key").add({
	{ ";q", group = "QuickFix" },
	{ ";qf", "<cmd>BqfToggle<CR>", desc = "Open Quick Fix" },
	{ ";qn", "<cmd>cnext<cr>", desc = "Next Quick Fix" },
	{ ";qp", "<cmd>cprevious", desc = "Previous Quick Fix" },
})
