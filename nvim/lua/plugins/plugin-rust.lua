if lazyvim_docs then
  -- LSP Server to use for Rust.
  -- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
  -- only for diagnostics. The rest of LSP support will still be
  -- provided by rust-analyzer.
  -- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
  vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
end

-- Switch to bacon-ls for rust
-- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

local diagnostics = vim.g.lazyvim_rust_diagnostics or "rust-analyzer"

return {
  {
    "danilamihailov/beacon.nvim",
  },
  {
    "preservim/tagbar",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "phaazon/hop.nvim",
    opts = {},
  },
  {
    "voldikss/vim-floaterm",
  },
  {
    "puremourning/vimspector",
  },
  {
    "folke/trouble.nvim",
  },
  {
    "m-demare/hlargs.nvim",
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- to show and customize ident lines.
  },
  {
    "windwp/nvim-autopairs", -- for smart pairing of brackets.
  },
  {
    "tpope/vim-surround", -- to quickly add, remove or change brackets surrounding any text.
  },
  {
    "RRethy/vim-illuminate", -- to highlight other uses of word under cursor.
  },
  {
    "numToStr/Comment.nvim", -- to quickly comment / uncomment text.
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        "codelldb",
      })

      if diagnostics == "bacon-ls" then
        vim.list_extend(opts.ensure_installed, { "bacon", "bacon-ls" })
      end
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    version = vim.fn.has("nvim-0.10.0") == 0 and "^5" or false,
    root = { "Cargo.toml", "rust-project.json" },
    config = function(_, opts)
      if LazyVim.has("mason.nvim") then
        local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
        local codelldb = package_path .. "/extension/adapter/codelldb"
        local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
        local uname = io.popen("uname"):read("*l")
        if uname == "Linux" then
          library_path = package_path .. "/extension/lldb/lib/liblldb.so"
        end
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
      end
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
    opts = function()
      return {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>cR", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "Code Action", buffer = bufnr })

            vim.keymap.set("n", "<leader>dr", function()
              vim.cmd.RustLsp("debuggables")
            end, { desc = "Rust Debuggables", buffer = bufnr })

            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, { desc = "rustaceanvim's hover actions", buffer = bufnr })
          end,

          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },

              -- Add clippy lints for Rust if using rust-analyzer
              checkOnSave = diagnostics == "rust-analyzer",

              -- Enable diagnostics if using rust-analyzer
              diagnostics = {
                enable = diagnostics == "rust-analyzer",
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
              },
            },
          },
        },
      }
    end,
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- {
  --   "rhysd/rust-doc.vim",
  --   opts = {},
  -- },

  -- If you enable this rustaceanvim will not functionm
  -- basically its as it outlines itself, it will disable
  -- rustaceanvim for lspconfig else if enabled, ensure Mason, installs
  -- bacon and bacon-ls
  --
  -- Correctly setup lspconfig for rust
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
      },
      servers = {
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = { enabled = false },
      },
      setup = {
        bacon_ls = function()
          require("lspconfig").bacon_ls.setup({
            init_options = {
              -- Bacon export filename (default: .bacon-locations).
              locationsFile = ".bacon-locations",
              -- Try to update diagnostics every time the file is saved (default: true).
              updateOnSave = true,
              --  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
              updateOnSaveWaitMillis = 700,
              -- Try to update diagnostics every time the file changes (default: true).
              updateOnChange = true,
              -- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
              validateBaconPreferences = true,
              -- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
              createBaconPreferencesFile = false,
              -- Run bacon in background for the bacon-ls job (default: true)
              runBaconInBackground = false,
              -- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
              runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
              -- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
              synchronizeAllOpenFilesWaitMillis = 1500,
            },
          })
          return true
        end,
      },
    },
  },

  -- Setup neotest for rust
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}
