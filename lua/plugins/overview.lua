return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  keys = {
    {
      "<leader>co",
      "<cmd>AerialToggle<cr>",
      desc = "LSP: [C]ode [O]verview window",
    },
  },
  opts = {
    layout = {
      max_width = { 80, 0.2 },
      min_width = { 15 },
    },
    close_automatic_events = { "unfocus", "switch_buffer" },
    highlight_on_hover = true,
    autojump = true,
    manage_folds = true,
    link_folds_to_tree = true,
    link_tree_to_folds = true,
    show_guides = true,
    filter_kind = false,
  },
  setup = function(_, opts)
    require('aerial.nvim').setup(opts)
    require("telescope").load_extension("aerial")
  end
}
