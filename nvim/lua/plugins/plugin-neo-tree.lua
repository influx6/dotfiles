return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      { "3rd/image.nvim", opts = {} },
    },
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
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
        window = {
          mappings = {
            ["."] = "toggle_hidden",
            ["H"] = "set_root",
          },
        },
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
