return {

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Completion framework:
      "hrsh7th/cmp-nvim-lsp",

      -- Useful completion sources:
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-vsnip",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/vim-vsnip",

      -- Other cmp completion plugins:
      -- "tzachar/cmp-ai",
      "hrsh7th/cmp-emoji",
      "dmitmel/cmp-cmdline-history",
      "teramako/cmp-cmdline-prompt.nvim",
      "lukas-reineke/cmp-rg",
      "chrisgrieser/cmp-nerdfont",
      "PhilippFeO/cmp-csv",
      "delphinus/cmp-ctags",
      "ray-x/cmp-treesitter",
      "ray-x/cmp-sql",
      "chrisgrieser/cmp_yanky",
      "codybuell/cmp-lbdb",
      "cmp-dotenv",
    },
    -- @param opts cmp.ConfigSchema
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      -- local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets

        completion = {
          completeopt = "menu,menuone,noselect,noinsert",
        },

        --preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        preselect = cmp.PreselectMode.None,

        window = cmp.config.window({
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        }),

        sources = cmp.config.sources({
          { name = "lazydev" },
          { name = "emoji" },
          { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
          { name = "path" },
          { name = "nerdfont" },
          { name = "cmp_csv" },
          { name = "rg" },
          { name = "sql" },
          { name = "treesitter" },
          { name = "nvim_lsp", keyword_length = 3 },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua", keyword_length = 2 },
          { name = "buffer", keyword_length = 2 },
          { name = "vsnip", keyword_length = 2 },
          { name = "calc" },
          { name = "lbdb" },
          { name = "cmdline-prompt" },
          { name = "cmdline_history" },
          {
            name = "cmp_yanky",
            option = {
              -- only suggest items which match the current filetype
              onlyCurrentFiletype = false,
              -- only suggest items with a minimum length
              minLength = 3,
            },
          },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              preselect_correct_word = true,
              enable_in_context = function()
                return true
              end,
            },
          },
          {
            name = "ctags",
            -- default values
            option = {
              executable = "ctags",
              trigger_characters = { "." },
              trigger_characters_ft = {},
            },
          },
          {
            {
              name = "dotenv",
              -- Defaults
              option = {
                path = ".",
                load_shell = true,
                item_kind = cmp.lsp.CompletionItemKind.Variable,
                eval_on_confirm = false,
                show_documentation = true,
                show_content_on_docs = true,
                documentation_kind = "markdown",
                dotenv_environment = ".*",
                file_priority = function(a, b)
                  -- Prioritizing local files
                  return a:upper() < b:upper()
                end,
              },
            },
          },
          -- { name = "cmp_ai" },
        }, {
          { name = "buffer" },
        }),

        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
          ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<tab>"] = function(fallback)
            return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
          end,
        }),

        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },

        experimental = {
          -- only show ghost text when we show ai completions
          ghost_text = vim.g.ai_cmp and {
            hl_group = "CmpGhostText",
          } or false,
        },

        sorting = defaults.sorting,
      }
    end,
    main = "lazyvim.util.cmp",
  },

  {
    "saghen/blink.cmp",
    enabled = true,
    optional = true,
  },

  -- ai completion
  -- {
  --   "tzachar/cmp-ai",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  -- },

  -- snippets
  --  {
  --  "hrsh7th/nvim-cmp",
  --  dependencies = {
  --    {
  --      "garymjr/nvim-snippets",
  --      opts = {
  --        friendly_snippets = true,
  --      },
  --      dependencies = { "rafamadriz/friendly-snippets" },
  --    },
  --  },
  --  opts = function(_, opts)
  --    opts.snippet = {
  --      expand = function(item)
  --        return LazyVim.cmp.expand(item.body)
  --      end,
  --    }
  --    if LazyVim.has("nvim-snippets") then
  --      table.insert(opts.sources, { name = "snippets" })
  --    end
  --  end,
  -- },
}
