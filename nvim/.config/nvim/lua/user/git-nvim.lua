local M = {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
		{
			"tpope/vim-fugitive",
		},
		{
			"lewis6991/gitsigns.nvim",
			event = "BufEnter",
			cmd = "Gitsigns",
		},
		{ "akinsho/git-conflict.nvim", version = "*", config = true },
		{
			"kdheepak/lazygit.nvim",
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{
					"<leader>lg",
					":!tmux new-window -c " .. vim.fn.getcwd() .. " -- lazygit <CR><CR>",
					desc = "Open lazy git",
				},
			},
		},
	},
	config = true,
}

M.config = function()
	local gitsigns = require("gitsigns")
	local neogit = require("neogit")
	neogit.setup({
		integration = {
			diffview = true,
		},
	})

	gitsigns.setup({
		signs = {
			add = {
				text = "┃+",
			},
			change = {
				text = "┋~",
			},
			delete = {
				text = "",
			},
			topdelete = {
				text = "",
			},
			changedelete = {
				text = "┃-",
			},
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		auto_attach = true,
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
		},
		attach_to_untracked = true,
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	})
end

return M
