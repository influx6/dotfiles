-- setup packer and install our plugins
require("alexewe.setup")

-- setup main keymaps, options and colorscheme
require("alexewe.core.options")
require("alexewe.core.keymaps")
require("alexewe.core.colors")

-- setup different plugins
require("alexewe.plugins.comment")
require("alexewe.plugins.lualine")
require("alexewe.plugins.nvim-cmp")
require("alexewe.plugins.nvim-tree")
require("alexewe.plugins.telescope")
-- load lsp plugins
require("alexewe.plugins.lsp.lspconfig")
require("alexewe.plugins.lsp.lspsaga")
require("alexewe.plugins.lsp.mason")
require("alexewe.plugins.lsp.null-ls")
-- load tree and code pairs
require("alexewe.plugins.autopairs")
require("alexewe.plugins.gitsigns")
require("alexewe.plugins.treesitter")
