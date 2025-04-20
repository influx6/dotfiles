return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>a", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Harpoon: Open harpoon window" })

      vim.keymap.set("n", "<leader>aa", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Mark file and add into Harpoon list" })
      vim.keymap.set("n", "<leader>az", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: toggle harpoon menu" })

      vim.keymap.set("n", "<leader>a1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon: select item 1" })
      vim.keymap.set("n", "<leader>a2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon: select item 2" })
      vim.keymap.set("n", "<leader>a3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon: select item 3" })
      vim.keymap.set("n", "<leader>a4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon: select item 4" })
      vim.keymap.set("n", "<leader>a5", function()
        harpoon:list():select(5)
      end, { desc = "Harpoon: select item 5" })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>ah", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: go to previous" })
      vim.keymap.set("n", "<leader>al", function()
        harpoon:list():next()
      end, { desc = "Harpoon: go to next" })
    end,
  },
}
