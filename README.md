# My neovim dotfiles

A lot of useful configuration example from [christ@machine](https://github.com/ChristianChiarulli/nvim)

## Plugin Manager

- [Lazy](https://github.com/folke/lazy.nvim)

## Installation

Using [GNU stow CLI](https://www.gnu.org/software/stow/manual/stow.html) for synlink directory

```bash
# save old nvim config
mv ~/.config/nvim ~/.config/nvim-old

# clone and stow
git clone --depth 1 https://github.com/Runchapon/.dotfiles-nvim.git
cd .dotfiles-nvim
stow nvim

# you can also you your old configuration with
NVIM_APPNAME="nvim-old" nvim
```

## Colorscheme

> [!TIP]
> Select from telescope using ``<Space> fc`` key bind
>
> - [x] catppuccin/nvim
> - [x] rebelot/kanagawa.nvim
> - [x] rose-pine/neovim
> - [x] folke/tokyonight.nvim

## Folder Structure

> [!TIP]
>
> ### Keymap using [which-key](https://github.com/folke/which-key.nvim)
>
> - All keymaps will be found in nvim/after/plugin directory

> [!TIP]
>
> ### File type configuration
>
> - More extended file types config will be found in nvim/ftplugin/{ft}.lua

<details>
<summary>Click Here</summary>
<pre>
```
├── .config
│   └── nvim
│       ├── after
│       │   └── plugin
│       │       ├── after.lua
│       │       ├── autosession.lua
│       │       ├── comment.lua
│       │       ├── conform.lua
│       │       ├── dap.lua
│       │       ├── flash.lua
│       │       ├── gitsign.lua
│       │       ├── goyo.lua
│       │       ├── lspconfig.lua
│       │       ├── nvim-tree.lua
│       │       ├── quick-fix.lua
│       │       ├── telescope.lua
│       │       ├── trasparent.lua
│       │       └── treesitter-context.lua
│       ├── ftplugin
│       │   ├── go.lua
│       │   ├── java.lua
│       │   ├── lua.lua
│       │   └── markdown.lua
│       ├── init.lua
│       ├── lua
│       │   └── france
│       │       ├── ai.lua
│       │       ├── autocomplete.lua
│       │       ├── autopair.lua
│       │       ├── autosession.lua
│       │       ├── base64.lua
│       │       ├── bigfiles-nvim.lua
│       │       ├── comment.lua
│       │       ├── core
│       │       │   ├── autocmds.lua
│       │       │   ├── keymaps.lua
│       │       │   ├── options.lua
│       │       │   └── spec.lua
│       │       ├── db.lua
│       │       ├── flash.lua
│       │       ├── git-nvim.lua
│       │       ├── image.lua
│       │       ├── indentline.lua
│       │       ├── lazy.lua
│       │       ├── lsp
│       │       │   ├── base64.lua
│       │       │   ├── formatter.lua
│       │       │   ├── linter.lua
│       │       │   ├── lspconfig.lua
│       │       │   ├── mason.lua
│       │       │   ├── none-ls.lua
│       │       │   ├── nvim-dap.lua
│       │       │   ├── nvim-lint.lua
│       │       │   ├── sonarlint.lua
│       │       │   └── test.lua
│       │       ├── luarock.lua
│       │       ├── markdown.lua
│       │       ├── multicursor.lua
│       │       ├── nvim-tree.lua
│       │       ├── obsidian.lua
│       │       ├── plantuml.lua
│       │       ├── plenary.lua
│       │       ├── projects.lua
│       │       ├── quick-fix.lua
│       │       ├── surround.lua
│       │       ├── telescope.lua
│       │       ├── todo-comment.lua
│       │       ├── toggleterm.lua
│       │       ├── transparent.lua
│       │       ├── treesitter.lua
│       │       ├── trouble.lua
│       │       ├── ui
│       │       │   ├── alpha-greeter.lua
│       │       │   ├── bufferline.lua
│       │       │   ├── colorpicker.lua
│       │       │   ├── colorscheme.lua
│       │       │   ├── devicon.lua
│       │       │   ├── dressing.lua
│       │       │   ├── lualine.lua
│       │       │   ├── noice.lua
│       │       │   └── wilder.lua
│       │       ├── undotree.lua
│       │       ├── vim-tmux.lua
│       │       ├── which-key.lua
│       │       ├── yuck.lua
│       │       └── zenmode.lua
│       ├── syntax
│       │   └── plantuml.vim
│       ├── tokyonight-day.json
│       ├── tokyonight-moon.json
│       ├── tokyonight-night.json
│       └── tokyonight-storm.json
├── .gitignore
└── README.md
```
</pre>
</details>

## Programming Language Configuration

### Java

> [!IMPORTANT]
>
> - Required Java21

> [!NOTE]
>
> #### Refer configuration from [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
>
> You will see it in [java ftplugin](.config/nvim/ftplugin/java.lua)
>
> ```
> Must change some configuration with TODO comment in file `.config/nvim/ftplugin/java.lua`
> ```
>
> - [x] Java Debug Adapter
> - [x] Java Unit test
> - [x] [Test Coverage](https://github.com/dsych/blanket.nvim)

### Go

> [!NOTE]
> You will see it in [go ftplugin](.config/nvim/ftplugin/go.lua)
>
> - [x] [Go Playground](https://github.com/jeniasaigak/goplay.nvim)
> - [x] [Test Coverage](https://github.com/rafaelsq/nvim-goc.lua)
> - [x] [Debug](https://github.com/leoluz/nvim-dap-go)

## Troubleshooting

Please run `:checkhealth` for more information
