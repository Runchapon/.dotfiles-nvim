local wk = require("which-key")
-- NOTE: Debugging
wk.add({
	-- Breakpoint
	{ "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>" },
	{
		"<leader>bc",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	},
	{
		"<leader>bl",
		"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	},
	{ "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>" },
	{ "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>" },

	-- DAP
	{ ";1", "<cmd>lua require'dap'.continue()<cr>" },
	{ ";2", "<cmd>lua require'dap'.step_over()<cr>" },
	{ ";3", "<cmd>lua require'dap'.step_into()<cr>" },
	{ ";4", "<cmd>lua require'dap'.step_out()<cr>" },
	{
		";dd",
		function()
			require("dap").disconnect()
			require("dapui").close()
		end,
		desc = "Disconnect DAP",
	},
	{
		";dt",
		function()
			require("dap").terminate()
			require("dapui").close()
		end,
		desc = "Disconnect Terminate",
	},
	{ ";dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "DAP repl toggle" },
	{ ";dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "DAP run last" },
	{
		";di",
		function()
			require("dap.ui.widgets").hover()
		end,
	},
	{
		";d?",
		function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end,
    desc = "DAP center widget"
	},
	{ ";df", "<cmd>Telescope dap frames<cr>" },
	{ ";dh", "<cmd>Telescope dap commands<cr>" },
	{
		";de",
		function()
			require("telescope.builtin").diagnostics({ default_text = ":E:" })
		end,
    desc = "Telescpoe diagnostics"
	},
}, { mode = "n" })
