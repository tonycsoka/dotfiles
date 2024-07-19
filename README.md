# dotfiles/.config/nvim

<img width="1800" alt="Screenshot 2024-07-19 at 23 20 13" src="https://github.com/user-attachments/assets/2f925a53-12bd-4fcf-8220-43e5c334f0b8">


<a href="https://dotfyle.com/tonycsoka/dotfiles-config-nvim"><img src="https://dotfyle.com/tonycsoka/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/tonycsoka/dotfiles-config-nvim"><img src="https://dotfyle.com/tonycsoka/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/tonycsoka/dotfiles-config-nvim"><img src="https://dotfyle.com/tonycsoka/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>


## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:tonycsoka/dotfiles ~/.config/tonycsoka/dotfiles
```

Open Neovim with this config:

```sh
NVIM_APPNAME=tonycsoka/dotfiles/.config/nvim nvim
```

## Plugins

Plugins are set up using a simple callback mechanism, so that setup and keymaps are close to the plugin spec, as per my personal preference. See the [harpoon.lua](.config/nvim/lua/jackdaw/plugins/harpoon.lua) spec file for example.

### bars-and-lines

+ [SmiteshP/nvim-navic](https://dotfyle.com/plugins/SmiteshP/nvim-navic)
### colorscheme

+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
+ [catppuccin/nvim](https://dotfyle.com/plugins/catppuccin/nvim)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
### debugging

+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
### diagnostics

+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
### editing-support

+ [folke/zen-mode.nvim](https://dotfyle.com/plugins/folke/zen-mode.nvim)
+ [echasnovski/mini.pairs](https://dotfyle.com/plugins/echasnovski/mini.pairs)
+ [debugloop/telescope-undo.nvim](https://dotfyle.com/plugins/debugloop/telescope-undo.nvim)
### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### git

+ [kdheepak/lazygit.nvim](https://dotfyle.com/plugins/kdheepak/lazygit.nvim)
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
+ [kyazdani42/nvim-web-devicons](https://dotfyle.com/plugins/kyazdani42/nvim-web-devicons)
### lsp

+ [onsails/lspkind.nvim](https://dotfyle.com/plugins/onsails/lspkind.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### marks

+ [ThePrimeagen/harpoon](https://dotfyle.com/plugins/ThePrimeagen/harpoon)
### nvim-dev

+ [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### session

+ [rmagatti/auto-session](https://dotfyle.com/plugins/rmagatti/auto-session)
### snippet

+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)
### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
### syntax

+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
+ [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)
### terminal-integration

+ [akinsho/toggleterm.nvim](https://dotfyle.com/plugins/akinsho/toggleterm.nvim)
### test

+ [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)
### utility

+ [chrisgrieser/nvim-early-retirement](https://dotfyle.com/plugins/chrisgrieser/nvim-early-retirement)
+ [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
## Language Servers

+ clangd
+ lua_ls
+ pyright
+ rust_analyzer
+ tsserver


 This readme was generated by [Dotfyle](https://dotfyle.com)
