return {
  {
    "voldikss/vim-floaterm",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
      close_on_exit = false,
      autochdir = true,
      shell = vim.o.shell,
      size = 20,
    },
  },
}
