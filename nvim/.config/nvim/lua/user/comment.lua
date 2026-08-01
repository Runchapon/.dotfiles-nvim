local M = {
	"numToStr/Comment.nvim",
	lazy = false,
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			-- event = "VeryLazy",
		},
		{
			"folke/ts-comments.nvim",
			-- opts = {},
			-- event = "VeryLazy",
			-- enabled = vim.fn.has("nvim-0.10.0") == 1,
		},
	},
}

function M.config()
	require("ts-comments").setup()
	local ft = require("Comment.ft")
	ft.mysql = "--%s"
	vim.g.skip_ts_context_commentstring_module = true
	---@diagnostic disable: missing-fields
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		-- pre_hook = function()
		-- 	return vim.bo.commentstring
		-- end,
		-- pre_hook = function(ctx)
		-- 	local U = require("Comment.utils")
		-- 	local location = nil
		-- 	if ctx.ctype == U.ctype.block then
		-- 		location = require("ts_context_commentstring.utils").get_cursor_location()
		-- 	elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.v then
		-- 		location = require("ts_context_commentstring.utils").get_visual_start_location()
		-- 	end
		-- 	return require("ts_context_commentstring.internal").calculate_comment_string({
		-- 		key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
		-- 		location = location,
		-- 	})
		-- end,
	})
end

return M
