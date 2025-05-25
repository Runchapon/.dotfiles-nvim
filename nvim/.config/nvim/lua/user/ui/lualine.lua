local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local lualine = require("lualine")
	local lazy_status = require("lazy.status") -- to configure lazy pending updates count

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local colors = {
		blue = "#80A0FF",
		cyan = "#79DAC8",
		black = "#080808",
		white = "#C6C6C6",
		jed = "#FF5189",
		violet = "#D183E8",
		grey = "#303030",
		green = "#3EFFDC",
		yellow = "#FFDA7B",
		fg = "#C3CCDC",
		bg = "#112638",
		inactive_bg = "#2C3043",
		add = "#99CE3E",
		remove = "#E52012",
	}

	local bubbles_theme = {
		normal = {
			a = { fg = colors.black, bg = colors.violet },
			b = { fg = colors.white, bg = colors.grey },
			c = { fg = colors.white },
		},

		insert = { a = { fg = colors.black, bg = colors.blue } },
		visual = { a = { fg = colors.black, bg = colors.cyan } },
		replace = { a = { fg = colors.black, bg = colors.red } },

		inactive = {
			a = { fg = colors.white, bg = colors.black },
			b = { fg = colors.white, bg = colors.black },
			c = { fg = colors.white },
		},
	}

	lualine.setup({
		options = {
			theme = bubbles_theme,
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					separator = { left = "" },
					right_padding = 1,
					icon_enabled = true,
					icon = "",
				},
			},
			lualine_b = {
				{ "filename" },
				{ "branch" },
			},
			lualine_c = {
				{
					"diff",
					colored = true, -- Displays a colored diff status if set to true
					diff_color = {
						added = { fg = colors.add },
						modified = { fg = colors.orange },
						removed = { fg = colors.remove },
					},
					symbols = { added = " ", modified = " ", removed = " " }, -- Changes the symbols used by the diff.
					-- source = nil, -- A function that works as a data source for diff.
					-- It must return a table as such:
					--   { added = add_count, modified = modified_count, removed = removed_count }
					-- or nil on failure. count <= 0 won't be displayed.
					cond = conditions.hide_in_width,
				},
				{
					"diagnostics",

					-- Table of diagnostic sources, available sources are:
					--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
					-- or a function that returns a table as such:
					--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
					sources = { "nvim_diagnostic", "nvim_lsp" },

					-- Displays diagnostics for the defined severity types
					sections = { "error", "warn", "info", "hint" },

					diagnostics_color = {
						-- Same values as the general color option can be used here.
						error = "DiagnosticError", -- Changes diagnostics' error color.
						warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
						info = "DiagnosticInfo", -- Changes diagnostics' info color.
						hint = "DiagnosticHint", -- Changes diagnostics' hint color.
					},
					symbols = { error = " ", warn = " ", hint = "󰌶 ", info = " " },
					colored = true, -- Displays diagnostics status in color if set to true.
					update_in_insert = false, -- Update diagnostics in insert mode.
					always_visible = false, -- Show diagnostics even if there are none.
				},
			},
			lualine_x = {
				{
					require("noice").api.status.mode.get,
					cond = require("noice").api.status.mode.has,
					color = { fg = "#ff9e64" },
				},
				{
					-- Lsp server name .
					function()
						local msg = "No Active Lsp"
						local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
						local clients = vim.lsp.get_active_clients()
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
							if client.name == "jdtls" then
								return "jdtls"
							end
						end
						return msg
					end,
					icon = " LSP:",
					color = { fg = "#FFFFFF", gui = "bold" },
				},
			},
			lualine_y = {
				{
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = "#ff9e64" },
				},
				"filetype",
				"progress",
				"encoding",
				{
					"fileformat",
					symbols = {
						mac = "", -- e711
						unix = "", -- e712
						dos = "", -- e70f
					},
				},
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 1 },
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = {},
	})
end

return M
