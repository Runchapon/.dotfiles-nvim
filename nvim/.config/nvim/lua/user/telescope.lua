local M = {
	"nvim-telescope/telescope.nvim",
	optional = true,
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
		"folke/todo-comments.nvim",
	},
}

function M.config()
	local actions = require("telescope.actions")
	local open_with_trouble = require("trouble.sources.telescope").open

	-- Use this to add more results without clearing the trouble list
	local add_to_trouble = require("trouble.sources.telescope").add

	require("telescope").setup({
		defaults = {
			prompt_prefix = "󰭎 " .. " ",
			selection_caret = " " .. " ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-t>"] = open_with_trouble,
				},
				n = {
					["<esc>"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["q"] = actions.close,
					["<C-t>"] = open_with_trouble,
				},
			},
		},
		pickers = {
			buffers = {
				previewer = false,
				layout_config = {
					width = 0.7,
					prompt_position = "top",
				},
			},
			builtin = {
				previewer = false,
				layout_config = {
					width = 0.3,
					prompt_position = "top",
				},
			},
			keymaps = {
				previewer = true,
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/.nodemodules/*" },
				previewer = true,
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 10,
					mirror = false,
				},
			},
			git_status = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			help_tags = {
				layout_config = {
					prompt_position = "top",
					scroll_speed = 4,
					height = 0.9,
					width = 0.9,
					preview_width = 0.55,
				},
			},
			live_grep = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			lsp_document_symbols = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			lsp_dynamic_workspace_symbols = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			lsp_implementations = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			lsp_references = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
			oldfiles = {
				previewer = false,
				layout_config = {
					width = 0.9,
					prompt_position = "top",
				},
			},
			colorscheme = {
				previewer = true,
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.9,
					height = 0.9,
					preview_cutoff = 1,
					mirror = false,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})
end

return M
