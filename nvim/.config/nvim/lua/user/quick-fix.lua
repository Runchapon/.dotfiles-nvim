local M = {
	"kevinhwang91/nvim-bqf",
	event = "VeryLazy",
}

function M.config()
	require("bqf").setup({
		auto_enable = false,
		magic_window = false,
		auto_resize_height = false,
		preview = {
			auto_preview = true,
			wrap = false,
			win_height = 12,
			win_vheight = 12,
			delay_syntax = 80,
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			show_title = false,
			should_preview_cb = function(bufnr, qwinid)
				local ret = true
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local fsize = vim.fn.getfsize(bufname)
				if fsize > 100 * 1024 then
					-- skip file size greater than 100k
					ret = false
				elseif bufname:match("^fugitive://") then
					-- skip fugitive buffer
					ret = false
				end
				return ret
			end,
		},
	})
end

return M
