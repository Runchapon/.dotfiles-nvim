local wk = require("which-key")
wk.add({
	{ "<leader>sr", "<cmd>AutoSession restore<CR>", desc = "[S]ession [R]estore" },
	{ "<leader>ss", "<cmd>AutoSession save<CR>", desc = "[S]ession [S]ave" },
})
