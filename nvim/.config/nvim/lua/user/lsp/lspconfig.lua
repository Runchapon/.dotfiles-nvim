local M = {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enable = true,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
    {
      "MysticalDevil/inlay-hints.nvim",
      event = "LspAttach",
    },
    -- JAVA
    -- https://github.com/javiorfo/nvim-springtime
    {
      "JavaHello/spring-boot.nvim",
      ft = { "java", "yaml", "jproperties" },
      dependencies = {
        "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
      },
      version = "*",
      enabled = function()
        local is_headless = #vim.api.nvim_list_uis() == 0
        if is_headless then
          return false
        end
        return true
      end,
    },
    {
      "JavaHello/java-deps.nvim",
      lazy = true,
      ft = "java",
      dependencies = {
        "mfussenegger/nvim-jdtls",
        "simrat39/symbols-outline.nvim",
      },
    },
    {
      -- https://github.com/mfussenegger/nvim-jdtls
      "mfussenegger/nvim-jdtls",
      ft = "java", -- Enable only on .java file extensions
    },
    {
      "simaxme/java.nvim",
      ft = "java",
    },
    {
      "elmcgill/springboot-nvim",
      ft = "java",
    },
    {
      "andreluisos/nvim-javagenie",
      dependencies = {
        "grapp-dev/nui-components.nvim",
        "MunifTanjim/nui.nvim",
      },
    },
    -- GO
    {
      "ray-x/go.nvim",
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "jeniasaigak/goplay.nvim",
      },
      event = { "CmdlineEnter" },
      ft = { "go", "gomod" },
      build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    -- RUST
    {
      "mrcjkb/rustaceanvim",
      version = '^6',
    },
    {
      'saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
    },
    -- k8s ecosystem
    { "towolf/vim-helm" },
    -- for kitty.conf
    { "fladson/vim-kitty" },
    {
      "allaman/kustomize.nvim",
      requires = "nvim-lua/plenary.nvim",
      ft = "yaml",
      opts = {},
    },
    -- angular
    { "joeveiga/ng.nvim" },
  },
}
M.config = function()
  require("inlay-hints").setup()

  -- import mason_lspconfig plugin
  local mason_lspconfig = require("mason-lspconfig")

  -- import cmp-nvim-lsp plugin
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  -- used to enable autocompletion (assign to every lsp server config)
  local capabilities = cmp_nvim_lsp.default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({ border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- Change the Diagnostic symbols in the sign column (gutter)
  -- (not in youtube nvim video)
  local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local c = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  vim.lsp.config("markdown_oxide", {
    -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
    -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
    capabilities = vim.tbl_deep_extend("force", c, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
  })

  -- lua
  vim.lsp.enable('lua_ls')
   -- npm i -g vscode-langservers-extracted
  vim.lsp.enable("html")
  -- npm install -g @angular/language-server
  vim.lsp.enable("angularls")
  -- npm install -g typescript typescript-language-server
  -- vim.lsp.enable('ts_ls')
  -- vim.lsp.enable("bashls")
  local opts = { noremap = true, silent = true }
  local ng = require("ng")
  vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
  vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
  vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)

  vim.lsp.config("clangd", {
    capabilities = capabilities,
    -- on_attach = on_attach,
    filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
    -- flags = lsp_flags,
    cmd = { "clangd", "--background-index" },
    single_file_support = true,
    root_markers = {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git",
    },
  })

  -- rust
  require('crates').setup()
  -- vim.lsp.enable('rust_analyzer')
  vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    capabilities = {
      experimental = {
        commands = {
          commands = { "rust-analyzer.showReferences", "rust-analyzer.runSingle", "rust-analyzer.debugSingle" }
        },
        serverStatusNotification = true
      }
    },
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
          extraArgs = { "--no-deps" }
        },
        checkOnSave = true,
        diagnostics = {
          enable = false,
        },
        lens = {
          debug = {
            enable = true
          },
          enable = true,
          implementations = {
            enable = true
          },
          references = {
            adt = {
              enable = true
            },
            enumVariant = {
              enable = true
            },
            method = {
              enable = true
            },
            trait = {
              enable = true
            }
          },
          run = {
            enable = true
          },
          updateTest = {
            enable = true
          }
        }
      },
    },
  })
end

return M
