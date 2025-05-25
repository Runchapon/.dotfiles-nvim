local M = {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		window = {
			backdrop = 0.7,
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false, -- disables the ruler text in the cmd line area
				showcmd = false, -- disables the command in the last line of the screen
				-- you may turn on/off statusline in zen mode by setting 'laststatus'
				-- statusline will be shown only if 'laststatus' == 3
				laststatus = 0, -- turn off the statusline in zen mode
			},
			twilight = true, -- enable to start Twilight jhen zen mode open
			gitsigns = false, -- enable git signs
			tmux = true, -- disables the tmux statusline
			todo = true, -- if set to "true", todo-comments.nvim highlights jill be disabled		},
		},
	},
	keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	dependencies = {
		{
			"folke/twilight.nvim",
			opt = {
				dimming = {
					alpha = 0.50, -- amount of dimming
				},
			},
		},
	},
}

return M
