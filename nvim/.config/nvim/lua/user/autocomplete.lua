local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
		{ "onsails/lspkind.nvim" },
		{ "nvimdev/lspsaga.nvim" },
	},
}

M.kind_icon = {
	Array = " ",
	Boolean = " ",
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = "󰉋 ",
	Function = " ",
	Interface = " ",
	Key = " ",
	Keyword = " ",
	Method = " ",
	-- Module = " ",
	Module = " ",
	Namespace = " ",
	Null = "󰟢 ",
	Number = " ",
	Object = " ",
	Operator = " ",
	Package = " ",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	String = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	require("luasnip/loaders/from_vscode").lazy_load()
	local lspkind = require("lspkind")

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
	vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				-- require("neotab").tabout()
				else
					fallback()
					-- require("neotab").tabout()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
		-- configure lspkind for vs-code like pictograms in completion menu
		formatting = {
			expandable_indicator = true,
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				maxwidth = 50,
				ellipsis_char = "...",
			}),
			before = function(entry, vim_item)
				vim_item.kind = M.kind_icon[vim_item.kind]
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					luasnip = "",
					buffer = "",
					path = "",
					emoji = "",
				})[entry.source.name]

				if entry.source.name == "emoji" then
					vim_item.kind = " "
					vim_item.kind_hl_group = "CmpItemKindEmoji"
				end

				return vim_item
			end,
		},
		sources = {
			{
				name = "nvim_lsp",
				option = {
					markdown_oxide = {
						keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
					},
				},
			},
			{ name = "luasnip" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "vim-dadbod-completion", priority = 700 },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = {
				border = "rounded",
				scrollbar = true,
				maxwidth = 15,
			},
			documentation = {
				border = "rounded",
			},
		},
		experimental = {
			ghost_text = false,
		},
	})

	-- Setup up vim-dadbod
	cmp.setup.filetype({ "sql" }, {
		sources = {
			{ name = "vim-dadbod-completion" },
			{ name = "buffer" },
		},
	})
end

return M
