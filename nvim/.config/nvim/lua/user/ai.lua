local M = {
	-- "David-Kunz/gen.nvim",{
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for 4%file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}

function M.config()

	-- os.getenv("GOOGLE_SEARCH_API_KEY")
	-- os.getenv("GOOGLE_SEARCH_ENGINE_ID")
	-- os.getenv("GEMINI_API_KEY")

	require("avante").setup({
		-- add any opts here
		-- for example
		provider = "gemini",
		-- openai = {
		-- 	endpoint = "https://api.openai.com/v1",
		-- 	model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
		-- 	timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
		-- 	temperature = 0,
		-- 	max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
		-- 	reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
		-- },
		-- web_search_engine = {
		-- 	provider = "google", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
		-- 	proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		-- },
	})
  require("avante.config").web_search_engine.provider = "google"
	-- require("avante.llm_tools").web_search({ query = "nvim" })
	-- require("gen").setup({
	--        model = "codellama:7b", -- The default model to use.
	--        quit_map = "q", -- set keymap to close the response window
	--        retry_map = "R", -- set keymap to re-send the current prompt
	--        accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
	--        host = "localhost", -- The host running the Ollama service.
	--        port = "8000", -- The port on which the Ollama service is listening.
	--        display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
	--        show_prompt = false, -- Shows the prompt submitted to Ollama.
	--        show_model = false, -- Displays which model you are using at the beginning of your chat session.
	--        no_auto_close = false, -- Never closes the window automatically.
	--        file = false, -- Write the payload to a temporary file to keep the command short.
	--        hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
	--        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
	-- Function to initialize Ollama
	-- command = function(options)
	--     local body = {model = options.model, stream = true}
	--     return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
	-- end,
	-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
	-- This can also be a command string.
	-- The executed command must return a JSON object with { response, context }
	-- (context property is optional).
	-- list_models = '<omitted lua function>', -- Retrieves a list of model names
	-- debug = false -- Prints errors and the command which is run.
	-- })
end

return M
