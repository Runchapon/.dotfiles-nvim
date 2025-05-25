local M = {
	-- https://github.com/rcarriga/nvim-dap-ui
	"rcarriga/nvim-dap-ui",
	dependencies = {
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		-- https://github.com/nvim-telescope/telescope-dap.nvim
		"nvim-telescope/telescope-dap.nvim", -- telescope integration with dap
		"nvim-neotest/nvim-nio",
		"rcarriga/cmp-dap",
		"leoluz/nvim-dap-go",
		{
			-- https://github.com/theHamsta/nvim-dap-virtual-text
			"theHamsta/nvim-dap-virtual-text",
			lazy = true,
			opts = {
				-- Display debug text as a comment
				commented = true,
				-- Customize virtual text
				display_callback = function(variable, buf, stackframe, node, options)
					if options.virt_text_pos == "inline" then
						return " = " .. variable.value
					else
						return variable.name .. " = " .. variable.value
					end
				end,
			},
		},
	},
}

M.config = function(_, opts)
	require("cmp").setup({
		enabled = function()
			return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end,
	})

	require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
		},
	})

	require("nvim-dap-virtual-text").setup({})

	local dap = require("dap")
	require("dapui").setup(opts)

	dap.listeners.after.event_initialized["dapui_config"] = function()
		require("dapui").open()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		-- Commented to prevent DAP UI from closing when unit tests finish
		-- require("dapui").close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		-- Commented to prevent DAP UI from closing when unit tests finish
		-- require("dapui").close()
	end

end

return M
