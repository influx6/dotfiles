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

-- Find a way to run bacon in terminal
-- BACON_SCRATCH = nil
-- BACON_BUFFER = nil
--
-- vim.api.nvim_create_autocmd("LsPAttach", {
--   pattern = { "*.rs" },
--   callback = function(args)
--     if BACON_BUFFER == nil then
--       BACON_SCRATCH = require("scratch").create({ filetype = "rust" })
--       BACON_BUFFER = vim.api.nvim_create_buf(true, false)
--
--       local filename = ("bacon_scratch.%s.%s"):format(os.tmpname(), "log")
--
--       vim.api.nvim_buf_set_name(BACON_BUFFER, filename)
--       vim.api.nvim_set_option_value("filetype", "shell", { buf = BACON_BUFFER })
--       vim.api.nvim_win_set_buf(0, BACON_BUFFER)
--
--       print("Created bacon buffer with name: %s", filename)
--
--       local augroup = vim.api.nvim_create_augroup("scratch", {})
--       vim.api.nvim_create_autocmd("BufDelete", {
--         group = augroup,
--         buffer = BACON_BUFFER,
--         once = true,
--         callback = function()
--           local _, err = os.remove(filename)
--           if err then
--             print(("Failed to remove temp file: %s due to %s"):format(filename, err))
--             return
--           end
--         end,
--       })
--
--       -- do something
--       -- local terminal = require("toggleterm.terminal").Terminal
--       -- BACON_TERM = terminal.create_terminal({
--       --   -- cmd = ("%s -c '%s %s'"):format(vim.o.shell, opts.command, opts.path),
--       --   cmd = "bacon -j bacon-ls",
--       --   close_on_exit = false,
--       --   dir = vim.uv.cwd(),
--       -- })
--     end
--   end,
-- })

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
    "TravonteD/luajob",
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
    ensure_installed = { "bacon-ls", "bacon" },
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
        tools = {
          float_win_config = { auto_focus = true },
        },
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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = {
          enabled = diagnostics == "bacon-ls",
        },
        rust_analyzer = { enabled = false },
      },
    },
  },

  {
    "Canop/nvim-bacon",
    config = function()
      require("bacon").setup({
        quickfix = {
          enabled = true, -- Enable Quickfix integration
          event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
        },
      })
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
}
