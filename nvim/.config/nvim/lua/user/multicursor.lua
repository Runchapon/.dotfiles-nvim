local M = {
	-- "smoka7/multicursors.nvim",
	-- event = "VeryLazy",
	-- dependencies = {
	-- 	"nvimtools/hydra.nvim",
	-- },
	-- opts = {},
	-- cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	-- keys = {
	-- 	{
	-- 		mode = { "v", "n" },
	-- 		"<Leader>m",
	-- 		"<cmd>MCstart<cr>",
	-- 		desc = "Create a selection for selected text or word under the cursor",
	-- 	},
	-- },
		"mg979/vim-visual-multi",
		-- enabled = false,
		keys = {
			{ "<M-e>", mode = { "n", "v" } },
			{ "<M-r>", mode = { "n", "v" } },
			{ "<C-Down>", mode = { "n", "v" } },
			{ "<C-Up>", mode = { "n", "v" } },
		},
		-- event = "VeryLazy",
		-- event = { "BufRead", "BufNewFile" },
		init = function()
			vim.cmd([[highlight! VM_Mono guibg=#004b72]])
			vim.cmd([[highlight! VM_Extend guibg=#004b72]])
			vim.g.VM_Mono_hl = "Visual"
			vim.g.VM_Mono = "Visual"
			vim.g.VM_Extend = "Visual"
			vim.g.VM_Extend_hl = "Visual"
			vim.g.VM_Insert_hl = "Visual"
			vim.g.VM_default_mappings = 0
			-- vim.g.VM_set_statusline = 0
			-- vim.g.VM_silent_exit = 1
			-- vim.g.VM_quit_after_leaving_insert_mode = 1
			vim.g.VM_show_warnings = 0
			vim.g.VM_maps = {
				-- ["Undo"] = "u",
				-- ["Redo"] = "<C-r>",
				["Find Under"] = "<M-e>",
				["Select All"] = "<M-a>",
				["Find Subword Under"] = "<M-e>",
				-- ["Skip Region"] = "<C-s>",
				["Select h"] = "<C-Left>",
				["Select l"] = "<C-Right>",
				["Add Cursor Up"] = "<C-Up>",
				["Add Cursor Down"] = "<C-Down>",
				["Select Operator"] = "gs",
				-- ["Mouse Cursor"] = "<C-LeftMouse>",
				-- ["Mouse Column"] = "<C-RightMouse>",
			}
			-- vim.g.VM_custom_remaps = {
			--   ["<C-c>"] = "<Esc>",
			-- }
			-- vim.g.VM_highlight_matches = ""
		end,
		-- config = function()
		--   vim.cmd([[highlight! VM_Mono guibg=#004b72]])
		--   vim.cmd([[highlight! VM_Extend guibg=#004b72]])
		--   vim.g.VM_Mono_hl = "Visual"
		--   vim.g.VM_Mono = "Visual"
		--   vim.g.VM_Extend = "Visual"
		--   vim.g.VM_Extend_hl = "Visual"
		--   vim.g.VM_Insert_hl = "Visual"
		--   vim.g.VM_default_mappings = 0
		--   vim.g.VM_maps = {}
		--   vim.g.VM_maps["Find Under"] = "<M-e>"
		--   vim.g.VM_maps["Find Subword Under"] = "<M-e>"
		--   vim.g.VM_maps["Select Operator"] = "gs"
		--   vim.g.VM_maps["Select All"] = "<M-r>"
		--   -- vim.g.VM_maps["Add Cursor Down"] = "<C-S-D-Down>"
		--   -- vim.g.VM_maps["Add Cursor Up"] = "<C-S-D-Up>"
		--   -- vim.cmd[[let g:VM_maps["Add Cursor Down"]             = '<C-Down>']]
		--   -- vim.cmd[[let g:VM_maps["Add Cursor Up"]               = '<C-Up>']]
		--
		--   -- vim.cmd[[let g:VM_maps["Select Cursor Down"]          = '<M-C-Down>']]
		--   -- vim.cmd[[let g:VM_maps["Select Cursor Down"]          = '<M-C-Up>']]
		--   -- vim.cmd[[let g:VM_maps["Add Cursor Down"]             = '<C-S-D-Down>']]
		--   -- vim.cmd[[let g:VM_maps["Add Cursor Up"]               = '<C-S-D-Up>']]
		-- end,
}

return M
