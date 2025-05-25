vim.notify(vim.fn.getcwd(), 0, {})
local home = os.getenv("HOME")

if vim.fn.getcwd() == home .. "/Obsidian/SecondBrain" then
	-- require("telekasten").setup({
	-- 	home = vim.fn.expand(home .. "/Obsidian/SecondBrain"), -- Put the name of your notes directory here
	-- })
	require("obsidian").setup({
		workspaces = {
			{
				name = "Second Brain",
				path = "~/Obsidian/SecondBrain/",
			},
		},
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "daily",
		},
    attachments = {
      img_folder = "~/Obsidian/SecondBrain/image/",
    },
		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = true,
		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",
		ui = {
			enable = false,
		},
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			return vim.fn.strftime("%Y%m%d") .. "-" .. title
		end,
	})
	require("which-key").add({
		{ "<leader>o", group = "Obsidian" },
		{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open Obsidian" },
		{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian Note" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian Backlinks" },
		{ "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian insert Template" },
		{ "<leader>of", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Find" },
		{ "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Obsidian Rename" },
		{ "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Obsidian Daily" },
		{ "<leader>op", "<cmd>Telekasten panel<cr>", desc = "Telekasten panel" },
		{ "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "MarkDown Table Mode" },
	}, { mode = "n" })
end
