return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = true,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = true,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = true,
      invert_intend_guides = true,
      inverse = false, -- invert background for search, diffs, statuslines and errors
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      -- vim.o.background = "light"
      vim.cmd([[ colorscheme gruvbox ]])
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    config = true,
    event = { "WinLeave" },
  },
}
