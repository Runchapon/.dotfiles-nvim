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
				},
			},
			lualine_b = {
				{
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 0, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					-- It can also be a function that returns
					-- the value of `shorting_target` dynamically.
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
						newfile = "[New]", -- Text to show for newly created file before first write
					},
				},
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
				{
					"searchcount",
					fmt = function(input, tabnr)
						if input ~= "" then
							return "search count: " .. input
						end
					end,
					timeout = 500,
				},
				{
					"selectioncount",
					fmt = function(input, tabnr)
						if input ~= "" then
							return "select count: " .. input
						end
					end,
				},
				{
					"tabs",
					tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
					max_length = vim.o.columns / 3, -- Maximum width of tabs component.
					-- Note:
					-- It can also be a function that returns
					-- the value of `max_length` dynamically.
					mode = 0, -- 0: Shows tab_nr
					-- 1: Shows tab_name
					-- 2: Shows tab_nr + tab_name
					icon = "tab",

					path = 1, -- 0: just shows the filename
					-- 1: shows the relative path and shorten $HOME to ~
					-- 2: shows the full path
					-- 3: shows the full path and shorten $HOME to ~

					-- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
					use_mode_colors = true,

					tabs_color = {
						-- Same values as the general color option can be used here.
						active = "lualine_c_diff_added_insert", -- Color for active tab.
						inactive = "lualine_c_inactive", -- Color for inactive tab.
					},

					show_modified_status = false, -- Shows a symbol next to the tab name if the file has been modified.
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
					},

					fmt = function(name, context)
						-- Show + if buffer is modified in tab
						local buflist = vim.fn.tabpagebuflist(context.tabnr)
						local winnr = vim.fn.tabpagewinnr(context.tabnr)
						local bufnr = buflist[winnr]
						local mod = vim.fn.getbufvar(bufnr, "&mod")

						return name .. (mod == 1 and " +" or "")
					end,
				},
			},
			lualine_x = {
				{
					require("noice").api.status.mode.get,
					cond = require("noice").api.status.mode.has,
					color = { fg = "#ff9e64" },
				},
				{
					"lsp_status",
					icon = " ", -- f013
					symbols = {
						-- Standard unicode symbols to cycle through for LSP progress:
						spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
						-- Standard unicode symbol for when LSP is done:
						done = "✓",
						-- Delimiter inserted between LSP names:
						separator = " ",
					},
					-- List of LSP names to ignore (e.g., `null-ls`):
					ignore_lsp = {},
					-- Display the LSP name
					show_name = true,
				},
				-- {
				--   -- Lsp server name .
				--   function()
				--     local msg = "No Active Lsp"
				--     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				--     local clients = vim.lsp.get_active_clients()
				--     if next(clients) == nil then
				--       return msg
				--     end
				--     for _, client in ipairs(clients) do
				--       local filetypes = client.config.filetypes
				--       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				--         return client.name
				--       end
				--       if client.name == "jdtls" then
				--         return "jdtls"
				--       end
				--     end
				--     return msg
				--   end,
				--   icon = " LSP:",
				--   color = { fg = "#FFFFFF", gui = "bold" },
				-- },
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
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			"mason",
			"lazy",
			"nvim-tree",
      "quickfix"
		},
	})
end

return M
