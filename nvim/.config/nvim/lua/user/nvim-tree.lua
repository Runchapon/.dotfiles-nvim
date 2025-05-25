local M = {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
}

function M.config()
	require("nvim-tree").setup({
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = true,
		sync_root_with_cwd = false,
		view = {
			relativenumber = true,
		},
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = false,
			full_name = false,
			highlight_opened_files = "none",
			root_folder_label = ":t",
			indent_width = 2,
			indent_markers = {
				enable = false,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				glyphs = {
					folder = {
						arrow_closed = "", -- arrow when folder is closed
						arrow_open = "", -- arrow when folder is open
					},
				},
			},
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "Dockerfile" },
			symlink_destination = true,
		},
		update_focused_file = {
			enable = true,
			debounce_delay = 15,
			update_root = true,
			ignore_list = {},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
		},
	})
end

return M
