local wk = require("which-key")
wk.add({
	{ "<leader>f", group = "Telescope" },
	{ "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
	{ "<leader>fB", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find" },
	{ "<leader>fc", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
	{ "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
	{ "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
	{ "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
	{ "<leader>fT", "<cmd>TodoTelecope<cr>", desc = "Find todos" },
	{ "<leader>fe", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Find tabs" },
	{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Find jumplist" },
	{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymap" },
})
