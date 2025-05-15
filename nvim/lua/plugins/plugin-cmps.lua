local diagnostics = vim.g.lazyvim_rust_diagnostics

function has_key(table, key)
  return table[key] ~= nil
end

function get_github_token()
  local envs = vim.fn.environ()
  if has_key(envs, "GH_TOKEN") then
    return envs["GH_TOKEN"]
  end
  vim.print("Unable to locate github GH_TOKEN environment var")
end

return {

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { "jmbuhr/cmp-pandoc-references" },

  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "dmitmel/cmp-digraphs",
      "nvim-lua/plenary.nvim",
      "milanglacier/minuet-ai.nvim",
      "moyiz/blink-emoji.nvim",
      "jdrupal-dev/css-vars.nvim",
      "MahanRahmati/blink-nerdfont.nvim",
      "rafamadriz/friendly-snippets",
      "mikavilpas/blink-ripgrep.nvim",
      "Kaiser-Yang/blink-cmp-git",
      "ribru17/blink-cmp-spell",
      "bydlw98/blink-cmp-env",
      "Kaiser-Yang/blink-cmp-dictionary",
      "Kaiser-Yang/blink-cmp-avante",
      "disrupted/blink-cmp-conventional-commits",
    },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter",
        -- Manually invoke minuet completion.
        -- ["<A-y>"] = function()
        --   require("minuet").make_blink_map()
        -- end,
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true, auto_show_delay_ms = 70 } },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          function(a, b)
            local sort = require("blink.cmp.fuzzy.sort")
            if a.source_id == "spell" and b.source_id == "spell" then
              return sort.label(a, b)
            end
          end,
          -- This is the normal default order, which we fall back to
          "score",
          "kind",
          "label",
        },
      },

      -- Signature: show function signatures (experimental)
      signature = { enabled = true },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
          "spell",
          "minuet",
          "avante", -- only after I enable avante
          "references",
          "dictionary",
          "omni",
          "emoji",
          "env",
          "css_vars",
          "nerdfont",
          "digraphs",
          "git",
          "conventional_commits",
        },
        per_filetype = {
          sql = { "snippets", "dadbod", "buffer" },
        },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            enabled = true, -- Whether or not to enable the provider
            async = false, -- Whether we should show the completions before this provider returns, without waiting for it
            timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
            score_offset = 200, -- Boost/penalize the score of the items
            -- opts = {}, -- Passed to the source directly, varies by source
            -- REMARK: All of these options may be functions to get dynamic behavior
            --
            -- See the type definitions for more information
            -- transform_items = nil, -- Function to transform the items before they're returned
            -- should_show_items = true, -- Whether or not to show the items
            -- max_items = nil, -- Maximum number of items to display in the menu
            -- min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
            -- fallbacks = {},
            -- override = nil, -- Override the source's functions
          },
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 90, -- Gives minuet higher priority among suggestions
          },
          avante = {
            score_offset = 90,
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
          -- 👇🏻👇🏻 add the ripgrep provider config below
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            score_offset = 80,
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- For many options, see `rg --help` for an exact description of
              -- the values that ripgrep expects.

              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- The number of lines to show around each match in the preview
              -- (documentation) window. For example, 5 means to show 5 lines
              -- before, then the match, and another 5 lines after the match.
              context_size = 5,

              -- The maximum file size of a file that ripgrep should include in
              -- its search. Useful when your project contains large files that
              -- might cause performance issues.
              -- Examples:
              -- "1024" (bytes by default), "200K", "1M", "1G", which will
              -- exclude files larger than that size.
              max_filesize = "1M",

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",

              -- Enable fallback to neovim cwd if project_root_marker is not
              -- found. Default: `true`, which means to use the cwd.
              project_root_fallback = true,

              -- The casing to use for the search in a format that ripgrep
              -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
              -- available options ripgrep supports, but you can try
              -- "--case-sensitive" or "--smart-case".
              search_casing = "--ignore-case",

              -- (advanced) Any additional options you want to give to ripgrep.
              -- See `rg -h` for a list of all available options. Might be
              -- helpful in adjusting performance in specific situations.
              -- If you have an idea for a default, please open an issue!
              --
              -- Not everything will work (obviously).
              additional_rg_options = {},

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Absolute root paths where the rg command will not be executed.
              -- Usually you want to exclude paths using gitignore files or
              -- ripgrep specific ignore files, but this can be used to only
              -- ignore the paths in blink-ripgrep.nvim, maintaining the ability
              -- to use ripgrep for those paths on the command line. If you need
              -- to find out where the searches are executed, enable `debug` and
              -- look at `:messages`.
              ignore_paths = {},

              -- Any additional paths to search in, in addition to the project
              -- root. This can be useful if you want to include dictionary files
              -- (/usr/share/dict/words), framework documentation, or any other
              -- reference material that is not available within the project
              -- root.
              additional_paths = {},

              -- Keymaps to toggle features on/off. This can be used to alter
              -- the behavior of the plugin without restarting Neovim. Nothing
              -- is enabled by default. Requires folke/snacks.nvim.
              toggles = {
                -- The keymap to toggle the plugin on and off from blink
                -- completion results. Example: "<leader>tg"
                on_off = nil,
              },

              -- Features that are not yet stable and might change in the future.
              -- You can enable these to try them out beforehand, but be aware
              -- that they might change. Nothing is enabled by default.
              future_features = {
                -- Workaround for
                -- https://github.com/mikavilpas/blink-ripgrep.nvim/issues/185. This
                -- is a temporary fix and will be removed in the future.
                issue185_workaround = false,

                backend = {
                  -- The backend to use for searching. Defaults to "ripgrep".
                  -- Available options:
                  -- - "ripgrep", always use ripgrep
                  -- - "gitgrep", always use git grep
                  -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
                  --   ripgrep
                  use = "ripgrep",
                },
              },

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
          },
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            score_offset = 70,
            opts = {
              -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- in `@nospell` captures.
              score_offset = 70,
              enable_in_context = function()
                local curpos = vim.api.nvim_win_get_cursor(0)
                local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
                local in_spell_capture = false
                for _, cap in ipairs(captures) do
                  if cap.capture == "spell" then
                    in_spell_capture = true
                  elseif cap.capture == "nospell" then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
          references = {
            name = "pandoc_references",
            module = "cmp-pandoc-references.blink",
            score_offset = 60,
          },
          dadbod = {
            name = "Dadbod", -- provides sql and db command completion.
            module = "vim_dadbod_completion.blink",
            score_offset = 60,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 50, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for git commits and markdown.
                -- By default, enabled for all file-types.
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          },
          dictionary = {
            score_offset = 20,
            module = "blink-cmp-dictionary",
            name = "Dict",
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            opts = {
              -- options for blink-cmp-dictionary
            },
          },
          css_vars = {
            name = "css-vars",
            module = "css-vars.blink",
            score_offset = 20,
            opts = {
              -- NOTE: The search is not optimized to look for variables in JS files.
              -- If you change the search_extensions you might get false positives and weird completion results.
              search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
            },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 30,
          },
          env = {
            name = "Env",
            score_offset = -10,
            module = "blink-cmp-env",
            opts = {
              item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
              show_braces = true,
              show_documentation_window = true,
            },
          },
          nerdfont = {
            module = "blink-nerdfont",
            name = "Nerd Fonts",
            score_offset = 10, -- Tune by preference
            opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
          },
          digraphs = {
            -- IMPORTANT: use the same name as you would for nvim-cmp
            name = "digraphs",
            module = "blink.compat.source",

            -- all blink.cmp source config options work as normal:
            score_offset = 10,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            --
            -- this is NOT the same as the opts in a plugin's lazy.nvim spec
            opts = {
              -- this is an option from cmp-digraphs
              cache_digraphs_on_start = true,

              -- If you'd like to use a `name` that does not exactly match nvim-cmp,
              -- set `cmp_name` to the name you would use for nvim-cmp, for instance:
              -- cmp_name = "digraphs"
              -- then, you can set the source's `name` to whatever you like.
            },
          },
          conventional_commits = {
            score_offset = 6,
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            ---@module 'blink-cmp-conventional-commits'
            ---@type blink-cmp-conventional-commits.Options
            opts = {}, -- none so far
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            score_offset = 5,
            opts = {
              -- options for the blink-cmp-git
              commit = {
                -- You may want to customize when it should be enabled
                -- The default will enable this when `git` is found and `cwd` is in a git repository
                -- enable = function() end
                -- You may want to change the triggers
                triggers = { "%" },
              },

              git_centers = {
                github = {
                  issue = { get_token = get_github_token },
                  pull_request = { get_token = get_github_token },
                  mention = { get_token = get_github_token },
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `gh` (or `curl`) are found and
                  -- remote contains `github.com`
                  -- issue = {
                  --     get_token = function() return '' end,
                  -- },
                  -- pull_request = {
                  --     get_token = function() return '' end,
                  -- },
                  -- mention = {
                  --     get_token = function() return '' end,
                  --     get_documentation = function(item)
                  --         local default = require('blink-cmp-git.default.github')
                  --             .mention.get_documentation(item)
                  --         default.get_token = function() return '' end
                  --         return default
                  --     end
                  -- }
                  --
                },
                gitlab = {
                  -- Those below have the same fields with `commit`
                  -- Those features will be enabled when `git` and `glab` (or `curl`) are found and
                  -- remote contains `gitlab.com`
                  -- issue = {
                  --     get_token = function() return '' end,
                  -- },
                  -- NOTE:
                  -- Even for `gitlab`, you should use `pull_request` rather than`merge_request`
                  -- pull_request = {
                  --     get_token = function() return '' end,
                  -- },
                  -- mention = {
                  --     get_token = function() return '' end,
                  --     get_documentation = function(item)
                  --         local default = require('blink-cmp-git.default.gitlab')
                  --            .mention.get_documentation(item)
                  --         default.get_token = function() return '' end
                  --         return default
                  --     end
                  -- }
                },
              },
            },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    ensure_installed = { "bacon-ls", "bacon", "pyright", "ruff" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "nvim-lua/plenary.nvim",
      "milanglacier/minuet-ai.nvim",
      "netmute/ctags-lsp.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            -- Ruff language server settings go here
            settings = {
              logLevel = "error",
              args = {},
              fixAll = true,
              organizeImports = true,
              showSyntaxErrors = true,
              lint = {
                enable = true,
                preview = true,
              },
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
        ruff = function()
          -- Register attachment to LspAttach to ensure ruff and pyright play nice
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client == nil then
                return
              end
              if client.name == "ruff" then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
              end
            end,
            desc = "LSP: Disable hover capability from Ruff",
          })

          -- Register attachment to LspAttach to ensure ruff and pyright play nice

          -- require("lspconfig").ruff.setup({
          --   init_options = {
          --     settings = {
          --       -- Ruff language server settings go here
          --       -- logLevel = "debug",
          --       args = {},
          --       fixAll = true,
          --       organizeImports = true,
          --       showSyntaxErrors = true,
          --       lint = {
          --         enable = true,
          --         preview = true,
          --       },
          --     },
          --   },
          -- })
        end,
        pyright = function()
          require("lspconfig").ruff.setup({
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  ignore = { "*" },
                },
              },
            },
          })
        end,
      },
    },
  },
}
