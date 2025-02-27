return {

  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "tflint" } },
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    specs = {
      {
        "ANGkeith/telescope-terraform-doc.nvim",
        ft = { "terraform", "hcl" },
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("terraform_doc")
          end)
        end,
      },
      {
        "cappyzawa/telescope-terraform.nvim",
        ft = { "terraform", "hcl" },
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("terraform")
          end)
        end,
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.packer,
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.diagnostics.terraform_validate,
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        terraform = { "terraform_validate" },
        tf = { "terraform_validate" },
      },
    },
  },
}
