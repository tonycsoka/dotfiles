return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "onsails/lspkind.nvim",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local lspconfig = require("lspconfig")


      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          -- on_attach = my_custom_on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "Lua 5.1" },
            diagnostics = {
              globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
            },
          },
        },
      })

      -- luasnip setup
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      local lspkind = require("lspkind")

      -- nvim-cmp setup
      local cmp = require("cmp")
      cmp.setup({ ---@diagnostic disable-line: redundant-parameter
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp', keyword_length = 1 },
          { name = 'buffer', keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
            local menu_icon = {
              buffer = 'Ω',
              nvim_lsp = 'λ',
              luasnip = '⋗',
              path = '󰙅',
            }

            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
      })
    end,
  },
}
