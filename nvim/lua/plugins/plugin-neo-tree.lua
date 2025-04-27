local print_me = function(state)
  local node = state.tree:get_node()
  print(node.name)
end

return {
  {

    -- HELP                                                            *neo-tree-help*
    --
    -- ? = show_help: Shows a popup window with all of the mappings for the current
    --                Neotree window. Pressing one of those keys will close the help
    --                screen and execute the chosen command in the original Neotree
    --                window. NOTE that selecting a line in the help window and
    --                pressing enter will not execute that command, it will just
    --                execute whatever the enter key is mapped to.
    --
    --
    -- NAVIGATION                                                *neo-tree-navigation*
    --
    -- Within the neo-tree window, for the filesystem source, the following mappings
    -- are defined by default. All built-in commands are listed here but some are not
    -- mapped by default. See |neo-tree-custom-commands| for details on how to use them
    -- in a custom mapping.
    --
    -- Note: The "selected" item is the line the cursor is currently on.
    --
    -- <             = prev_source: Switches to the previous source.
    --
    -- >             = next_source: Switches to the next source.
    --
    -- <bs>          = navigate_up: Moves the root directory up one level.
    --
    -- .             = set_root:    Changes the root directory to the currently
    --                              selected folder.
    --
    -- <space>       = toggle_node  Expand or collapse a node with children, which
    --                              may be a directory or a nested file.
    --
    -- <2-LeftMouse> = open:        Expand or collapse a folder. If a file is selected,
    --                              open it in the window closest to the tree.
    --
    -- <cr>          = open:        Same as above.
    --
    -- C             = close_node:  Close node if it is open, else close it's parent.
    --
    -- z         = close_all_nodes: Close all nodes in the tree.
    --
    --          close_all_subnodes: Same as "close_node", but also recursively collapse
    --                              all subnodes, similar to "close_all_nodes"
    --
    --            expand_all_nodes: Expand all directory nodes in the tree recursively.
    --
    -- P          = toggle_preview: Toggles "preview mode", see |neo-tree-preview-mode|
    --
    -- l           = focus_preview: Focus the active preview window
    --
    -- <C-f>      = scroll_preview: Scrolls preview window down (without focusing it)
    --                              see |neo-tree-preview-mode| for params
    --
    -- <C-b>      = scroll_preview: Scrolls preview window up (without focusing it)
    --                              see |neo-tree-preview-mode| for params
    --
    -- <esc>      = revert_preview: Ends "preview_mode" if it is enabled, and reverts
    --                              any preview windows to what was being shown before
    --                              preview mode began.
    --
    -- S             = open_split:  Same as open, but opens in a new horizontal split.
    --
    -- s             = open_vsplit: Same as open, but opens in a vertical split.
    --
    --          open_rightbelow_vs: Same as open_vsplit, but opens in a right window
    --                              of the vertical split.
    --
    --           open_leftabove_vs: Same as open_vsplit, but opens in a left window
    --                              of the vertical split.
    --
    -- t             = open_tabnew: Same as open, but opens in a new tab.
    --
    --                   open_drop: Same as open, but opens with the |:drop| command.
    --
    --               open_tab_drop: Same as open, but opens in a new tab with the
    --                              |:drop| command with the |:tab| modifier.
    --
    -- w = open_with_window_picker: Uses the `window-picker` plugin to select a window
    --                              to open the selected node in. Requires that
    --                              https://github.com/s1n7ax/nvim-window-picker
    --                              be installed.
    --
    --    split_with_window_picker: Same as `open_with_window_picker` but opens split
    --                              in selected node instead.
    --
    --   vsplit_with_window_picker: Same as `open_with_window_picker` but opens
    --                              vertical split in selected node instead.
    --
    -- [g      = prev_git_modified: Jump to the previous file reported by `git status`
    --                              that is within the current working directory.
    --                              This will loop around if you are on the last one.
    --
    -- ]g      = next_git_modified: Jump to the next file reported by `git status`
    --                              that is within the current working directory.
    --                              This will loop around if you are on the last one.
    --
    --
    -- FILE ACTIONS                                            *neo-tree-file-actions*
    -- a    = add:                  Create a new file OR directory. Add a `/` to the
    --                              end of the name to make a directory. This command
    --                              supports an optional `config.show_path` option
    --                              which controls what portion of the path is shown
    --                              in the prompt. The choices for this option are:
    --
    --                              `"none"`:     which is the default.
    --                              `"relative"`: shows the portion which is relative
    --                                          to the current root of the tree.
    --                              `"absolute"`: is the full path to the current
    --                                          directory.
    --
    --                              The file path also supports BASH style brace
    --                              expansion. sequence style ("{00..05..2}") as well
    --                              as nested braces. Here are some examples how this
    --                              expansion works.
    --
    --                              "x{a..e..2}"           : "xa", "xc", "xe"
    --                              "file.txt{,.bak}"      : "file.txt", "file.txt.bak"
    --                              "./{a,b}/{00..02}.lua" : "./a/00.lua", "./a/01.lua",
    --                                                       "./a/02.lua", "./b/00.lua",
    --                                                       "./b/01.lua", "./b/02.lua"
    --
    -- A    = add_directory:        Create a new directory, in this mode it does not
    --                              need to end with a `/`. The path also supports
    --                              BASH style brace expansion as explained in `add`
    --                              command. Also accepts `config.show_path` options
    --
    -- d    = delete:               Delete the selected file or directory.
    --                              Supports visual selection.~
    --
    -- i    = show_file_details     Show file details in a popup window, such as size
    --                              and last modified date.
    --
    --                              This command supports two optional options to
    --                              change the format string for file timestamps,
    --                              `config.created_format` for the date created and
    --                              `config.modified_format` for the date last
    --                              modified (see `:h os.date()`). Instead of a
    --                              format string, these options also accept a
    --                              function that takes in the date in seconds and
    --                              returns a string to display. They also accept
    --                              "relative" as a valid format, which will format
    --                              the timestamp as a human-readable relative date.
    --
    --                              If the options are not set, they default to the
    --                              format string "%Y-%m-%d %I:%M %p".
    --
    -- r    = rename:               Rename the selected file or directory.
    --
    -- b    = rename_basename:      Rename the selected file or directory without the
    --                              extension.
    --
    -- y    = copy_to_clipboard:    Mark file to be copied.
    --                              Supports visual selection.~
    --
    -- x    = cut_to_clipboard:     Mark file to be cut (moved).
    --                              Supports visual selection.~
    --
    -- p    = paste_from_clipboard: Copy/move each marked file to the selected folder.
    --
    -- c    = copy:                 Copy the selected file or directory.
    --                              Also accepts the optional `config.show_path` option
    --                              like the add file action.
    --
    -- m    = move:                 Move the selected file or directory.
    --                              Also accepts the optional `config.show_path` option
    --                              like the add file action.
    --
    --
    -- VIEW CHANGES                                            *neo-tree-view-changes*
    -- H  = toggle_hidden:  Toggle whether hidden (filtered items) are shown or not.
    --
    -- R  = refresh:        Rescan the filesystem and redraw the tree. Changes made
    --                      within nvim should be detected automatically, but this is
    --                      useful for changes made elsewhere.
    --
    -- o  = order_by...     Show help menu for order by choices.
    --
    -- oc = ...created:     Sort the tree by created date.
    --
    -- od = ...diagnostics: Sort by diagnostic severity.
    --
    -- og = ...git_status:  Sort by git status.
    --
    -- om = ...modified:    Sort by last modified date.
    --
    -- on = ...name:        Sort by name (default sort).
    --
    -- os = ...size:        Sort by size.
    --
    -- ot = ...type:        Sort by type.
    --
    "nvim-neo-tree/neo-tree.nvim",
    enabled = vim.g.file_manager == "neotree", -- use oil.nvim going forward
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      { "3rd/image.nvim", opts = {} },
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>h",
        function()
          require("neo-tree.command").execute({ toggle = false })
        end,
        desc = "Go to NeoTree Buffer",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (Cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Cwd Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Current File Directory)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["?"] = print_me,
          ["\\"] = "refresh",
          ["i"] = "show_file_details",
          ["a"] = "add", -- adds a file in the location
          ["A"] = "add_directory",
          ["l"] = "open",
          ["h"] = "close_node",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = false,
              -- use_image_nvim = true,
              -- title = 'Neo-tree Preview',
            },
          },
        },
      },
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
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
      nesting_rules = {
        ["package.json"] = {
          pattern = "^package%.json$", -- <-- Lua pattern
          files = { "package-lock.json", "yarn*" }, -- <-- glob pattern
        },
        ["go"] = {
          pattern = "(.*)%.go$", -- <-- Lua pattern with capture
          files = { "%1_test.go" }, -- <-- glob pattern with capture
        },
        ["js-extended"] = {
          pattern = "(.+)%.js$",
          files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
        },
        ["docker"] = {
          pattern = "^dockerfile$",
          ignore_case = true,
          files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
        },
      },
    },
  },
}
