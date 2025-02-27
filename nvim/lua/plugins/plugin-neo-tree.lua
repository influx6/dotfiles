return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = true,
            -- use_image_nvim = true,
            -- title = 'Neo-tree Preview',
          },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          never_show = {},
        },
      },
    },
  },
}
