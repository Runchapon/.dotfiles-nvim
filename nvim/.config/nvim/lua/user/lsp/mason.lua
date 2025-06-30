local M = {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mason-org/mason-registry",
	},
}

function M.config()
	local servers = {
		"lua_ls",
		"jdtls",
		"gopls",
		"bashls",
		"jsonls",
		"ast_grep",
		"pyright",
		"markdown_oxide",
		"rust_analyzer",
    "ts_ls",
	}
	local tools = {
		"prettier", -- prettier formatter
		"stylua", -- lua formatter
		"isort", -- python formatter
		"black", -- python formatter
		"pylint",
		"eslint_d",
		"ast_grep",
		"java-debug-adapter",
		"java-test",
		"vscode-spring-boot-tools",
		"google-java-format",
		"golangci-lint",
		"markdownlint",
	}

	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_enable = {
			"tsserver",
			"angularls",
			"gopls",
			exclude = {
				"jdtls",
			},
		},
	})

	require("mason-tool-installer").setup({
		ensure_installed = tools,
	})

	-- vim.api.nvim_command("MasonToolsInstall")
end

return M
