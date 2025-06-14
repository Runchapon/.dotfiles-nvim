local wk = require("which-key")

require("goplay").setup()
require("dap-go").setup()
require("go").setup({
	tag_transform = true,
	lsp_keymaps = false,
})

local dap = require("dap")
dap.adapters.delve = function(callback, config)
	if config.mode == "remote" and config.request == "attach" then
		callback({
			type = "server",
			host = config.host or "127.0.0.1",
			port = config.port or "38697",
		})
	else
		callback({
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
				detached = vim.fn.has("win32") == 0,
			},
		})
	end
end

-- NOTE: https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- NOTE: For test coverage
-- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
vim.opt.switchbuf = "useopen"

local goc = require("nvim-goc")
goc.setup({ verticalSplit = false }) -- default to horizontal

-- If you need custom arguments, you can supply an array as in the example below.
-- vim.keymap.set('n', '<Leader>gcf', function() goc.Coverage({ "-race", "-count=1" }) end, {silent=true})
-- vim.keymap.set('n', '<Leader>gct', function() goc.CoverageFunc({ "-race", "-count=1" }) end, {silent=true})

vim.keymap.set("n", "]a", goc.Alternate, { silent = true })
vim.keymap.set("n", "[a", goc.AlternateSplit, { silent = true }) -- set verticalSplit=true for vertical

local cf = function(testCurrentFunction)
	local cb = function(path, index)
		if path then
			-- `xdg-open|open` command performs the same function as double-clicking on the file.
			-- change from `xdg-open` to `open` on MacOSx
			vim.cmd(':silent exec "!open file://' .. path .. "\\\\#file" .. index .. '"')
		end
	end

	if testCurrentFunction then
		goc.CoverageFunc(nil, cb, 0)
	else
		goc.Coverage(nil, cb)
	end
end

-- If you want to open it in your browser, you can use the commands below.
-- You need to create a callback function to configure which command to use to open the HTML.
-- On Linux, `xdg-open` is generally used, on MacOSx it's just `open`.
-- vim.keymap.set("n", ";gca", cf, { silent = true })
-- vim.keymap.set("n", ";gcb", function()
-- 	cf(true)
-- end, { silent = true })

-- default colors
vim.api.nvim_set_hl(0, "GocNormal", { link = "Comment" })
-- vim.api.nvim_set_hl(0, 'GocCovered', {link='String'})
vim.api.nvim_set_hl(0, "GocCovered", { fg = "#33801A" })
vim.api.nvim_set_hl(0, "GocUncovered", { link = "Error" })

wk.add({
	{ ";", group = "Specific File Type: Go" },
	{ ";s", vim.lsp.buf.signature_help, desc = "Go signature help" },
	{ ";w", group = "Go workspace" },
	{ ";wr", vim.lsp.buf.remove_workspace_folder, desc = "Go remove workspace" },
	{ ";wa", vim.lsp.buf.add_workspace_folder, desc = "Go add workspace" },
	{
		";wl",
		function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end,
		desc = "Go list workspace",
	},
	{ ";p", group = "Go Playground" },
	{ ";pt", "<cmd>GPToggle<CR>", desc = "Go Playground toggle" },
	{ ";pe", "<cmd>GPExec<CR>", desc = "Go Playground Execute" },
	{ ";pf", "<cmd>GPExecFile<CR>", desc = "Go Playground Execute File" },
	{ "<leader>rn", "<cmd>GoRename<CR>", desc = "Go rename" },
	{ ";t", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Go Debug Test" },
	{ ";gcf", goc.Coverage, desc = "run for the whole File", { silent = true } },
	{ ";gct", goc.CoverageFunc, desc = "run only for a specific Test unit", { silent = true } },
	{ ";gcc", goc.ClearCoverage, desc = "clear coverage highlights", { silent = true } },
	{ ";gca", cf, desc = "open test coverage in browser", { silent = true } },
	{ mode = "n" },
	{
		"<leader>ca",
		function()
			require("go.codeaction").run_range_code_action()
		end,
		desc = "Go Code Action",
		mode = { "n", "v" },
	},
})
