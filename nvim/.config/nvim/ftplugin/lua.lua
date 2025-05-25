-- NOTE: require luarock https://luarocks.org/
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.3",
				path = {
          "lua.lua",
					"?.lua",
					"?/init.lua",
					vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
					vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
					"/usr/share/5.3/?.lua",
					"/usr/share/lua/5.3/?/init.lua",
				},
			},
			workspace = {
				library = {
					vim.fn.expand("~/.luarocks/share/lua/5.3"),
					"/usr/share/lua/5.3",
				},
			},
		},
	},
})
