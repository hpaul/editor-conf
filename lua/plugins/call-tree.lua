return {
  "jmacadie/telescope-hierarchy.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  keys = {
    {
      "<leader>si",
      "<cmd>Telescope hierarchy incoming_calls<cr>",
      desc = "LSP: [S]earch [I]ncoming Calls",
    },
    {
      "<leader>so",
      "<cmd>Telescope hierarchy outgoing_calls<cr>",
      desc = "LSP: [S]earch [O]utgoing Calls",
    },
  },
  opts = {
    extensions = {
      hierarchy = {
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 0.30,
          mirror = false,
          prompt_position = "bottom",
        },
        theme = "ivy",
      },
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require("telescope").setup(opts)
    require("telescope").load_extension("hierarchy")
  end,
}
