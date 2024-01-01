return {
-- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  -- Session management. This saves your session in the background,
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    lazy = false,

    opts = {
      auto_session_enable_last_session = false,
      auto_session_enabled             = true,
      auto_session_create_enabled      = true,
      auto_save_enabled                = true,
      auto_restore_enabled             = nil,
      auto_session_suppress_dirs       = { "~/Projects", "~/Downloads", "/" },
      auto_session_allowed_dirs        = nil,
      auto_session_use_git_branch      = nil,
    },
    -- stylua: ignore
    keys = { },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
