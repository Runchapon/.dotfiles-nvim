vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
})

require("rust-tools").setup({
	tools = {
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			auto = true,
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		-- on_attach = on_attach,
		settings = {
-- 			on_attach = function(client, bufnr)
				-- Note that the hints are only visible after rust-analyzer
				-- has finished loading and you have to edit the file
				-- to trigger a re-render.
				-- https://rust-analyzer.github.io/book/other_editors.html
			-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) -- Enable Rust inlay hints
			-- 	keymap.set_keymap(client, bufnr) -- Reuse the keymap function
			-- end,
			root_markers = { "Cargo.toml", ".git" },
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					-- command = "clippy",
					command = "wl-copy",
				},
			},
		},
	},
})
