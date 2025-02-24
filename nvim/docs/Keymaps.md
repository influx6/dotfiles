# Keymaps

LSP keymaps
These are the default keymaps that will be added when an LSP server is attached to the current buffer. For more info see Customizing LSP Keymaps

LSP Server keymaps
Sometimes it may be necessary to add keymaps for a specific LSP server. Lazyutils provides a keys LSP option for this purpose.

```
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
        },
      },
    },
  },
}
```
