-- vim.cmd.colorscheme("rose-pine-moon")
vim.cmd.colorscheme("kanagawa")
local wk = require("which-key")

wk.add({
	{ "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
	{ "<leader>nh", "<cmd>nohlsearch<CR>", desc = "Clear hightlights search" },

	{ "<leader>t", group = "Tab" },
	{ "<leader>tN", "<cmd>tabnew<cr>", desc = "Open new Tab" },
	{ "<leader>tx", "<cmd>tabclose<cr>", desc = "Close current Tab" },
	{ "<leader>tn", "<cmd>tabn<cr>", desc = "Go to next Tab" },
	{ "<leader>tp", "<cmd>-tabp<cr>", desc = "Go to previous Tab" },
	{ "<leader>to", "<cmd>tabnew %<cr>", desc = "Open current buffer in new tab" },

	{ "<leader>s", group = "Split" },
	{ "<leader>|", "<C-w>v", desc = "Split window vertically" }, -- split window vertically
	{ "<leader>-", "<C-w>s", desc = "Split window horizontally" }, -- split window horizontally
	{ "<leader>e", "<C-w>=", desc = "Make splits equal size" }, -- make split windows equal width & height
	{ "<leader>x", "<cmd>close<CR>", desc = "Close current split" }, -- close current split window
	{ "<leader>j", "<C-w>-", desc = "make split window height shorter" },
	{ "<leader>k", "<C-w>+", desc = "make split windows height taller" },
	{ "<leader>l", "<C-w>>5", desc = "make split windows width bigger" },
	{ "<leader>h", "<C-w><5", desc = "make split windows width smaller" },

	-- NOTE: undo tree
	{ "<leader>u", ":UndotreeToggle<cr>", desc = "Open Undo Tree" },
})
