require("simaxme-java").setup()
-- JDTLS (Java LSP) configuration
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/.config/nvim/jdtls-workspace/" .. project_name
local home = os.getenv("HOME")
local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
local path_to_jdtls = path_to_mason_packages .. "/jdtls"
local equinox_launcher_path = vim.fn.glob(path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local extend_cap = jdtls.extendedClientCapabilities
extend_cap.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

--  NOTE: REFERENCE
-- https://neovimcraft.com/plugin/mfussenegger/nvim-jdtls/
-- https://github.com/mfussenegger/nvim-jdtls
--  NOTE: Needed for debugging
-- clone https://github.com/microsoft/java-debug.git and build
local bundles = {}

local java_debug_path = path_to_mason_packages .. "/java-debug-adapter/"
local java_debug_bundle =
	vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
if java_debug_bundle[1] ~= "" then
	vim.list_extend(bundles, java_debug_bundle)
end

local java_dependency_bundle = vim.split(
	vim.fn.glob(
		home
			.. "/.config/nvim/vscode-java-dependency/jdtls.ext/com.microsoft.jdtls.ext.core/target/com.microsoft.jdtls.ext.core-*.jar"
	),
	"\n"
)
if java_dependency_bundle[1] ~= "" then
	vim.list_extend(bundles, java_dependency_bundle)
end

--  NOTE: Needed for running/debugging unit tests
-- clone https://github.com/microsoft/vscode-java-test
-- npm install && npm run build-plugin
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(vim.env.HOME .. "/.config/nvim/vscode-java-test/server/*.jar", true), "\n")
)

require("java-deps").setup({})
require("spring_boot").setup({
	java_cmd = "java",
	jdtls_name = "jdtls",
	log_file = home .. "/.local/state/nvim/spring-boot-ls.log",
	exploded_ls_jar_data = false,
	server = {
		cmd = {},
	},
	autocmd = true,
})
vim.list_extend(bundles, require("spring_boot").java_extensions())

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {

	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		-- "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/bin/java",
		--  TODO: must be your java path (full path if have more than one java version)
		"/usr/lib/jvm/java-21-openjdk/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- Eclipse jdtls location
		"-jar",
		equinox_launcher_path,

		--  TODO: Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
		"-configuration",
		vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	-- root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			-- TODO: Replace this with the absolute path to your main java version (JDK 21 or higher)
			home = "/usr/lib/jvm/java-21-openjdk/bin/java",
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				-- TODO: Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtime name parameters need to match specific Java execution environments.
				-- See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
				runtimes = {
					-- {
					-- 	name = "JavaSE-11",
					-- 	path = "/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home",
					-- },
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/bin",
					},
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk/bin",
					},
					{
						name = "JavaSE-24",
						path = "/usr/lib/jvm/java-24-openjdk/bin",
					},
				},
			},
			-- Decompiler (should have a decompiler bundle on init options)
			contentProvider = {
				preferred = "fernflower",
			},
			-- Inlay hint
			-- inlayhints = {
			--   parameterNames = {
			--     enabled = "all",
			--   },
			-- },
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				-- Formatting works by default, but you can refer to a specific file/URL if you choose
				settings = {
					-- url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
					session_file = "~/.config/nvim/formatconf/java-google-style.xml",
					-- url = "~/.config/nvim/formatconf/java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		extendedClientCapabilities = extend_cap,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles,
	},
}

-- Add dap configurations based on your language/adapter settings
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
require("dap").configurations.java = {
	{
		name = "Debug Launch (2GB)",
		type = "java",
		request = "launch",
		vmArgs = "" .. "-Xmx2g ",
	},
	{
		name = "Debug Attach (8000)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 8000,
	},
	{
		name = "Debug Attach (5005)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 5005,
	},
	{
		name = "My Custom Java Run Configuration",
		type = "java",
		request = "launch",
		-- You need to extend the classPath to list your dependencies.
		-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
		-- classPaths = {},

		-- If using multi-module projects, remove otherwise.
		-- projectName = "yourProjectName",

		-- javaExec = "java",
		-- mainClass = "replace.with.your.fully.qualified.MainClass",

		-- If using the JDK9+ module system, this needs to be extended
		-- `nvim-jdtls` would automatically populate this property
		-- modulePaths = {},
		vmArgs = "" .. "-Xmx2g ",
	},
}

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
	jdtls.setup_dap({
		hotcodereplace = "auto",
		config_overrides = {
			-- cwd = ".",
			-- vmArgs = "",
			-- noDebug = false,
		},
	})
	require("symbols-outline").setup()
	-- local root_dir = require("jdtls").setup.find_root(root_files)
	require("jdtls.dap").setup_dap_main_class_configs()
	-- require("java-deps").attach(client, bufnr, root_dir)

	local blanket = require("blanket")
	blanket.setup({
		-- can use env variables and anything that could be interpreted by expand(), see :h expandcmd()
		-- OPTIONAL
		report_path = vim.fn.getcwd() .. "/target/site/jacoco/jacoco.xml",
		-- refresh gutter every time we enter java file
		-- defauls to empty - no autocmd is created
		filetypes = "java",
		-- for debugging purposes to see whether current file is present inside the report
		-- defaults to false
		silent = true,
		-- can set the signs as well
		signs = {
			priority = 10,
			incomplete_branch = "█",
			uncovered = "█",
			covered = "█",
			sign_group = "Blanket",

			-- and the highlights for each sign!
			-- useful for themes where below highlights are similar
			incomplete_branch_color = "WarningMsg",
			covered_color = "Statement",
			uncovered_color = "Error",
		},
	})
	blanket.stop()

	local springboot_nvim = require("springboot-nvim")
	require("which-key").add({
		{ ";", group = "Specific File Type: Java" },
		{ ";o", "<cmd>lua require 'jdtls'.organize_imports() <CR>", desc = "Java organize import" },
		{ ";u", "<cmd>lua require 'jdtls'.update_projects_config() <CR>", desc = "Java update project config" },
		{ ";t", "<cmd>lua require 'jdtls'.test_class() <CR>", desc = "Java test class" },
		{ ";m", "<cmd>lua require 'jdtls'.test_nearest_method() <CR>", desc = "Java test nearest method" },
		{ ";r", springboot_nvim.boot_run, desc = "[J]ava [R]un Spring Boot" },
		{ ";n", "<cmd> CreateNewJavaFile <cr>", desc = "Create new java file" },
		{ ";N", "<cmd> SpringBootNewProject <cr>", desc = "Create new spring boot project" },
		{
			";D",
			function()
				require("java-deps").toggle_outline()
			end,
			desc = "Toggle dependencies tree",
		},
		{
			";a",
			function()
				require("telescope.builtin").lsp_workspace_symbols({})
			end,
			desc = "List spring annotation",
		},
		{
			";bs",
			"<cmd> lua require 'blanket'.start() <cr>",
			desc = "start the plugin, useful when filetype property is not set",
		},
		{
			";be",
			"<cmd> lua require 'blanket'.stop() <cr>",
			desc = "stop displaying coverage and cleanup autocmds, watcher etc.",
		},
		{
			";br",
			"<cmd> lua require 'blanket'.refresh() <cr>",
			desc = "manually trigger a refresh of signs, useful when filetype property is not set",
		},
		{
			";bp",
			"<cmd> lua require 'blanket'.pick_report_path() <cr>",
			desc = "pick a new report_path and refresh the report",
		},
		-- { ";bs", blanket.set_report_path(<new_file_path>), desc = "change report_path to a new value and refresh the gutter based on the new report" },
	})
	-- run the setup function with default configuration
	springboot_nvim.setup()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
