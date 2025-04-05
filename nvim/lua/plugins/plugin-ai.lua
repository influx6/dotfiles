return {

  -- AI completion
  {

    -- Default Config
    --
    -- default_config = {
    -- Enable or disable auto-completion. Note that you still need to add
    -- Minuet to your cmp/blink sources. This option controls whether cmp/blink
    -- will attempt to invoke minuet when minuet is included in cmp/blink
    -- sources. This setting has no effect on manual completion; Minuet will
    -- always be enabled when invoked manually. You can use the command
    -- `Minuet cmp/blink toggle` to toggle this option.
    --     cmp = {
    --         enable_auto_complete = true,
    --     },
    --     blink = {
    --         enable_auto_complete = true,
    --     },
    --     -- LSP is recommended only for built-in completion. If you are using
    --     -- `cmp` or `blink`, utilizing LSP for code completion from Minuet is *not*
    --     -- recommended.
    --     lsp = {
    --         enabled_ft = {},
    --         -- Filetypes excluded from LSP activation. Useful when `enabled_ft` = { '*' }
    --         disabled_ft = {},
    --         -- Enables automatic completion triggering using `vim.lsp.completion.enable`
    --         enabled_auto_trigger_ft = {},
    --         -- Filetypes excluded from autotriggering. Useful when `enabled_auto_trigger_ft` = { '*' }
    --         disabled_auto_trigger_ft = {},
    --         -- if true, when the user is using blink or nvim-cmp, warn the user
    --         -- that they should use the native source instead.
    --         warn_on_blink_or_cmp = true,
    --     },
    --     virtualtext = {
    --         -- Specify the filetypes to enable automatic virtual text completion,
    --         -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
    --         -- completion even if the filetype is not on your auto_trigger_ft list.
    --         auto_trigger_ft = {},
    --         -- specify file types where automatic virtual text completion should be
    --         -- disabled. This option is useful when auto-completion is enabled for
    --         -- all file types i.e., when auto_trigger_ft = { '*' }
    --         auto_trigger_ignore_ft = {},
    --         keymap = {
    --             accept = nil,
    --             accept_line = nil,
    --             accept_n_lines = nil,
    --             -- Cycle to next completion item, or manually invoke completion
    --             next = nil,
    --             -- Cycle to prev completion item, or manually invoke completion
    --             prev = nil,
    --             dismiss = nil,
    --         },
    --         -- Whether show virtual text suggestion when the completion menu
    --         -- (nvim-cmp or blink-cmp) is visible.
    --         show_on_completion_menu = false,
    --     },
    --     provider = 'codestral',
    --     -- the maximum total characters of the context before and after the cursor
    --     -- 16000 characters typically equate to approximately 4,000 tokens for
    --     -- LLMs.
    --     context_window = 16000,
    --     -- when the total characters exceed the context window, the ratio of
    --     -- context before cursor and after cursor, the larger the ratio the more
    --     -- context before cursor will be used. This option should be between 0 and
    --     -- 1, context_ratio = 0.75 means the ratio will be 3:1.
    --     context_ratio = 0.75,
    --     throttle = 1000, -- only send the request every x milliseconds, use 0 to disable throttle.
    --     -- debounce the request in x milliseconds, set to 0 to disable debounce
    --     debounce = 400,
    --     -- Control notification display for request status
    --     -- Notification options:
    --     -- false: Disable all notifications (use boolean false, not string "false")
    --     -- "debug": Display all notifications (comprehensive debugging)
    --     -- "verbose": Display most notifications
    --     -- "warn": Display warnings and errors only
    --     -- "error": Display errors only
    --     notify = 'warn',
    --     -- The request timeout, measured in seconds. When streaming is enabled
    --     -- (stream = true), setting a shorter request_timeout allows for faster
    --     -- retrieval of completion items, albeit potentially incomplete.
    --     -- Conversely, with streaming disabled (stream = false), a timeout
    --     -- occurring before the LLM returns results will yield no completion items.
    --     request_timeout = 3,
    --     -- If completion item has multiple lines, create another completion item
    --     -- only containing its first line. This option only has impact for cmp and
    --     -- blink. For virtualtext, no single line entry will be added.
    --     add_single_line_entry = true,
    --     -- The number of completion items encoded as part of the prompt for the
    --     -- chat LLM. For FIM model, this is the number of requests to send. It's
    --     -- important to note that when 'add_single_line_entry' is set to true, the
    --     -- actual number of returned items may exceed this value. Additionally, the
    --     -- LLM cannot guarantee the exact number of completion items specified, as
    --     -- this parameter serves only as a prompt guideline.
    --     n_completions = 3,
    --     -- Defines the length of non-whitespace context after the cursor used to
    --     -- filter completion text. Set to 0 to disable filtering.
    --     --
    --     -- Example: With after_cursor_filter_length = 3 and context:
    --     --
    --     -- "def fib(n):\n|\n\nfib(5)" (where | represents cursor position),
    --     --
    --     -- if the completion text contains "fib", then "fib" and subsequent text
    --     -- will be removed. This setting filters repeated text generated by the
    --     -- LLM. A large value (e.g., 15) is recommended to avoid false positives.
    --     after_cursor_filter_length = 15,
    --     -- proxy port to use
    --     proxy = nil,
    --     provider_options = {
    --         -- see the documentation in each provider in the following part.
    --     },
    --     -- see the documentation in the `Prompt` section
    --     default_system = {
    --         template = '...',
    --         prompt = '...',
    --         guidelines = '...',
    --         n_completion_template = '...',
    --     },
    --     default_system_prefix_first = {
    --         template = '...',
    --         prompt = '...',
    --         guidelines = '...',
    --         n_completion_template = '...',
    --     },
    --     default_fim_template = {
    --         prompt = '...',
    --         suffix = '...',
    --     },
    --     default_few_shots = { '...' },
    --     default_chat_input = { '...' },
    --     default_few_shots_prefix_first = { '...' },
    --     default_chat_input_prefix_first = { '...' },
    --     -- Config options for `Minuet change_preset` command
    --     presets = {}
    -- }
    "milanglacier/minuet-ai.nvim",
    config = function()
      -- provider = 'openai_fim_compatible',
      -- provider_options = {
      --        openai_fim_compatible = {
      --            api_key = 'DEEPSEEK_API_KEY',
      --            name = 'deepseek',
      --            optional = {
      --                max_tokens = 256,
      --                top_p = 0.9,
      --            },
      --        },
      --    },
      --
      -- provider = 'openai_compatible',
      -- provider_options = {
      --     openai_compatible = {
      --         end_point = 'https://api.deepseek.com/v1/chat/completions',
      --         api_key = 'DEEPSEEK_API_KEY',
      --         name = 'deepseek',
      --         optional = {
      --             max_tokens = 256,
      --             top_p = 0.9,
      --         },
      --     },
      -- },
      --
      --
      --     provider = 'openai_fim_compatible',
      -- n_completions = 1, -- recommend for local model for resource saving
      -- -- I recommend beginning with a small context window size and incrementally
      -- -- expanding it, depending on your local computing power. A context window
      -- -- of 512, serves as an good starting point to estimate your computing
      -- -- power. Once you have a reliable estimate of your local computing power,
      -- -- you should adjust the context window to a larger value.
      -- context_window = 512,
      -- provider_options = {
      --     openai_fim_compatible = {
      --         api_key = 'TERM',
      --         name = 'Ollama',
      --         end_point = 'http://localhost:11434/v1/completions',
      --         model = 'qwen2.5-coder:7b',
      --         optional = {
      --             max_tokens = 56,
      --             top_p = 0.9,
      --         },
      --     },
      -- },
      --
      --
      -- Customizing Prompts
      --
      --
      -- local gemini_prompt = [[
      -- You are the backend of an AI-powered code completion engine. Your task is to
      -- provide code suggestions based on the user's input. The user's code will be
      -- enclosed in markers:
      --
      -- - `<contextAfterCursor>`: Code context after the cursor
      -- - `<cursorPosition>`: Current cursor location
      -- - `<contextBeforeCursor>`: Code context before the cursor
      -- ]]
      --
      -- local gemini_few_shots = {}
      --
      -- gemini_few_shots[1] = {
      --     role = 'user',
      --     content = [[
      -- # language: python
      -- <contextBeforeCursor>
      -- def fibonacci(n):
      --     <cursorPosition>
      -- <contextAfterCursor>
      --
      -- fib(5)]],
      -- }
      --
      -- local gemini_chat_input_template =
      --     '{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}'
      --
      --
      -- gemini_few_shots[2] = require('minuet.config').default_few_shots[2]
      --
      -- require('minuet').setup {
      --     provider = 'gemini',
      --     provider_options = {
      --         gemini = {
      --             system = {
      --                 prompt = gemini_prompt,
      --             },
      --             few_shots = gemini_few_shots,
      --             chat_input = {
      --                 template = gemini_chat_input_template,
      --             },
      --             optional = {
      --                 generationConfig = {
      --                     maxOutputTokens = 256,
      --                     topP = 0.9,
      --                 },
      --                 safetySettings = {
      --                     {
      --                         category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
      --                         threshold = 'BLOCK_NONE',
      --                     },
      --                     {
      --                         category = 'HARM_CATEGORY_HATE_SPEECH',
      --                         threshold = 'BLOCK_NONE',
      --                     },
      --                     {
      --                         category = 'HARM_CATEGORY_HARASSMENT',
      --                         threshold = 'BLOCK_NONE',
      --                     },
      --                     {
      --                         category = 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
      --                         threshold = 'BLOCK_NONE',
      --                     },
      --                 },
      --             },
      --         },
      --     },
      -- }
      require("minuet").setup({
        -- Your configuration options here
        -- Ollama based
        provider = "openai_fim_compatible",
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 1512,
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://127.0.0.1:11434/v1/completions",
            model = "qwen2.5-coder:14b",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      -- provider = "openai",
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
      --
      -- For Deepseek-r1
      -- provider = "ollama",
      -- ollama = {
      --   model = "deepseek-r1:70b",
      -- },
      --
      provider = "ollama",
      ollama = {
        -- model = "deepseek-r1:70b",
        -- model = "qwq:latest", -- to use latest qwuen reasoning model
        model = "gemma3:12b", -- to use latest google open source model
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
