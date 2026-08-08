require("which-key").add({
	{
		"<leader>i",
		function()
			local image = require("image")
			if image.is_enabled() then
				image.disable()
			else
				image.enable()
			end
		end,
		desc = "Toggle Image Preview",
	},
})
