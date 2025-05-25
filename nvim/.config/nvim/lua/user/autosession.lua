local M = {
	"rmagatti/auto-session",
}

function M.config()
	local auto_session = require("auto-session")
	auto_session.setup({
		suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    auto_restore = false,
	})
end

return M
