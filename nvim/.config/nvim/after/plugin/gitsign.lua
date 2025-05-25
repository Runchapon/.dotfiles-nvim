local wk = require("which-key")
local gitsigns = require("gitsigns")
wk.add({
	{ ";g", group = "GitSign" },
	{ ";gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
	{ ";gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
	{ ";gb", "<cmd>Git blame<cr>", desc = "Blame" },
	{ ";gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
	{ ";gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
	{ ";gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
	{ ";gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
	{ ";gl", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Line Highlight" },
	{ ";gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Word Diff" },
	{ ";gt", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle Signs" },
	{ ";gn", "<cmd>Neogit<cr>", desc = "Open Neogit" },
	{ ";dv", group = "DiffView" },
	{ ";dvo", "<cmd>DiffviewOpen<cr>", desc = "Open Diff" },
	{ ";dvc", "<cmd>DiffviewClose<cr>", desc = "Close Diff" },
	{
		"[h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "]h", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end,
		desc = "Next Hunk",
	},
	{
		"]h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "[h", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end,
		desc = "Prev Hunk",
	},
})
