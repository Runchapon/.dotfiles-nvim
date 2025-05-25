local M = {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		main = "render-markdown",
		opts = {},
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"tadmccorkle/markdown.nvim",
			"dhruvasagar/vim-table-mode",
			"junegunn/goyo.vim",
		}, -- if you prefer nvim-web-devicons -- config = function() -- require('obsidian').get_client().opts.ui.enable = false
		-- vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
		-- require('render-markdown').setup({})
		-- end,
	},
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = { "google-chrome-stable", "--new-window" },
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}

function M.config()
	require("markdown").setup()
	require("render-markdown").setup({
		file_types = { "markdown", "vimwiki" },
		-- only_render_image_at_cursor = true,
		checkbox = {
			-- Turn on / off checkbox state rendering
			enabled = true,
			unchecked = {
				-- Replaces '[ ]' of 'task_list_marker_unchecked'
				icon = "⬜︎",
				-- Highlight for the unchecked icon
				highlight = "RenderMarkdownUnchecked",
			},
			checked = {
				-- Replaces '[x]' of 'task_list_marker_checked'
				icon = "✅",
				-- Highligh for the checked icon
				highlight = "RenderMarkdownChecked",
			},
			-- Define custom checkbox states, more involved as they are not part of the markdown grammar
			-- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
			-- Can specify as many additional states as you like following the 'todo' pattern below
			--   The key in this case 'todo' is for healthcheck and to allow users to change its values
			--   'raw': Matched against the raw text of a 'shortcut_link'
			--   'rendered': Replaces the 'raw' value when rendering
			--   'highlight': Highlight for the 'rendered' icon
			custom = {
				todo = { raw = "[-]", rendered = "📌", highlight = "RenderMarkdownTodo" },
				inprogress = { raw = "[>]", rendered = "⏳", highlight = "RenderMarkdowInfo" },
				cancel = { raw = "[~]", rendered = "❌", highlight = "ObsidianTilde" },
				important = { raw = "[!]", rendered = "⚠️ ", highlight = "ObsidianImportant" },
			},
		},
	})

	-- " set to 1, nvim will open the preview window after entering the Markdown buffer
	-- " default: 0
	local g = vim.g
	g.mkdp_auto_start = 0

	-- " set to 1, the nvim will auto close current preview window when changing
	-- " from Markdown buffer to another buffer
	-- " default: 1
	g.mkdp_auto_close = 1

	-- " set to 1, Vim will refresh Markdown when saving the buffer or
	-- " when leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
	-- " move the cursor
	-- " default: 0
	g.mkdp_refresh_slow = 0

	-- " set to 1, the MarkdownPreview command can be used for all files,
	-- " by default it can be use in Markdown files only
	-- " default: 0
	g.mkdp_command_for_global = 0

	-- " set to 1, the preview server is available to others in your network.
	-- " By default, the server listens on localhost (127.0.0.1)
	-- " default: 0
	g.mkdp_open_to_the_world = 0

	-- " use custom IP to open preview page.
	-- " Useful when you work in remote Vim and preview on local browser.
	-- " For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
	-- " default empty
	g.mkdp_open_ip = ""

	-- " specify browser to open preview page
	-- " for path with space
	-- " valid: `/path/with\ space/xxx`
	-- " invalid: `/path/with\\ space/xxx`
	-- " default: ''
	g.mkdp_browser = ""

	-- " set to 1, echo preview page URL in command line when opening preview page
	-- " default is 0
	g.mkdp_echo_preview_url = 0

	-- " a custom Vim function name to open preview page
	-- " this function will receive URL as param
	-- " default is empty
	g.mkdp_browserfunc = ""

	-- " options for Markdown rendering
	-- " mkit: markdown-it options for rendering
	-- " katex: KaTeX options for math
	-- " uml: markdown-it-plantuml options
	-- " maid: mermaid options
	-- " disable_sync_scroll: whether to disable sync scroll, default 0
	-- " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
	-- "   middle: means the cursor position is always at the middle of the preview page
	-- "   top: means the Vim top viewport always shows up at the top of the preview page
	-- "   relative: means the cursor position is always at relative positon of the preview page
	-- " hide_yaml_meta: whether to hide YAML metadata, default is 1
	-- " sequence_diagrams: js-sequence-diagrams options
	-- " content_editable: if enable content editable for preview page, default: v:false
	-- " disable_filename: if disable filename header for preview page, default: 0
	g.mkdp_preview_options = {
		mkit = {},
		katex = {},
		uml = {},
		maid = {},
		disable_sync_scroll = 0,
		sync_scroll_type = "middle",
		hide_yaml_meta = 1,
		sequence_diagrams = {},
		flowchart_diagrams = {},
		content_editable = { v = false },
		disable_filename = 0,
		toc = {},
	}

	-- " use a custom Markdown style. Must be an absolute path
	-- " like '/Users/username/markdown.css' or expand('~/markdown.css')
	g.mkdp_markdown_css = ""

	-- " use a custom highlight style. Must be an absolute path
	-- " like '/Users/username/highlight.css' or expand('~/highlight.css')
	g.mkdp_highlight_css = ""

	-- " use a custom port to start server or empty for random
	g.mkdp_port = ""

	-- " preview page title
	-- " ${name} will be replace with the file name
	g.mkdp_page_title = "「${name}」"

	-- " use a custom location for images
	g.mkdp_images_path = "/home/user/.markdown_images"

	-- " recognized filetypes
	-- " these filetypes will have MarkdownPreview... commands
	g.mkdp_filetypes = "markdown"

	-- " set default theme (dark or light)
	-- " By default the theme is defined according to the preferences of the system
	g.mkdp_theme = "dark"

	-- " combine preview window
	-- " default: 0
	-- " if enable it will reuse previous opened preview window when you preview markdown file.
	-- " ensure to set let g:mkdp_auto_close = 0 if you have enable this option
	g.mkdp_combine_preview = 0

	-- " auto refetch combine preview contents when change markdown buffer
	-- " only when g:mkdp_combine_preview is 1
	g.mkdp_combine_preview_auto_refresh = 1
end

return M
