return {
  {
    "norcalli/nvim-colorizer.lua",
    -- event = require("event-triggers").buffer_with_content_events,
    config = function()
      require("colorizer").setup()
    end,
  },
}
