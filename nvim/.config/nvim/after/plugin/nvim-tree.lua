local wk = require("which-key")
wk.add({
	{ "<leader>e", group = "NvimTree" },
	{ "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" }, -- toggle file explorer on current file
	{ "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" }, -- collapse file explorer
	{ "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" }, -- refresh file explorer
	{ "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
})
