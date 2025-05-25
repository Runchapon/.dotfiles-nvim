local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
		-- 'mrded/nvim-lsp-notify',
	},
}

function M.config()
	require("notify").setup({
		render = "compact",
		stages = "fade",
		background_colour = "#000000",
	})
	-- require('lsp-notify').setup({
	--   notify = require('notify'),
	-- })
	require("noice").setup({
		lsp = {
			progress = {
				view = "mini",
			},
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		views = {
			mini = {
				backend = "mini",
				relative = "editor",
				align = "message-right",
				timeout = 2000,
				reverse = true,
				focusable = false,
				position = {
					row = "10%",
					col = "100%",
					-- col = 0,
				},
				size = {
					width = "auto",
					-- width = "100px",
					height = "auto",
					max_height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				zindex = 60,
				win_options = {
					winbar = "",
					foldenable = false,
					winblend = 30,
					winhighlight = {
						FloatBorder = "NoiceMiniFloatBorder",
						Normal = "NoiceMini",
						IncSearch = "",
						CurSearch = "",
						Search = "",
					},
				},
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})
	require("transparent").clear_prefix("Notify")
	require("transparent").clear_prefix("NoiceMini")
end

return M
