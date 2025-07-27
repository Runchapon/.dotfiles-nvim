local M = {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-vim-test",
		-- { "fredrikaverpil/neotest-golang", ft = "go", version = "*" },
		{ "nvim-neotest/neotest-go" },
		{ "rafaelsq/nvim-goc.lua" },
		{ "rcasia/neotest-java", ft = "java" },
		{ "dsych/blanket.nvim", ft = "java" },
	},
}

M.config = function()
	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				return message
			end,
		},
	}, neotest_ns)
	-- https://github.com/fredrikaverpil/neotest-golang
	require("neotest").setup({
		adapters = {
			require("neotest-go")({
				-- recursive_run = true,
			}), -- Registration
			require("neotest-java")({
				-- junit_jar = vim.env.HOME .. "/.local/share/nvim/neotest-java/junit-platform-console-standalone-1.10.1.jar",
				-- incremental_build = true,
			}),
			require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}),
		},
	})
end

return M
