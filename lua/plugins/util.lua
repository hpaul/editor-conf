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
  {
    "svermeulen/vim-yoink",
    lazy = false,
    dependencies = {
      -- "svermeulen/vim-cutlass"
    },
    keys = {
      { "y", "<plug>(YoinkYankPreserveCursorPosition)", mode = {"n", "x"}, desc = "Yanking without changing cursor position" },
      { "p", "<plug>(YoinkPaste_p)", mode = "n", desc = "Pasing on steroids" },
      { "P", "<plug>(YoinkPaste_P)", mode = "n", desc = "Pasing on steroids" },
      { "gp", "<plug>(YoinkPaste_gp)", mode = "n", desc = "Pasing on steroids" },
      { "gP", "<plug>(YoinkPaste_gP)", mode = "n", desc = "Pasing on steroids" },
      { "<C-n>", "<plug>(YoinkPostPasteSwapBack)", mode = "n", desc = "Cycle paste history backward" },
      { "<C-p>", "<plug>(YoinkPostPasteSwapForward)", mode = "n", desc = "Cycle paste history forward" },
      { "<C-=>", "<plug>(YoinkPostPasteToggleFormat)", mode = "n", desc = "Toggle between pasting with formatting or not" },
    },
    config = function()
      vim.cmd([[
         let g:yoinkIncludeDeleteOperations = 1
         let g:yoinkSyncSystemClipboardOnFocus = 0
         let g:yoinkAutoFormatPaste = 1
      ]])
    end
  },
  {
    "Konfekt/vim-CtrlXA",
    enabled = true,
    lazy = false,
    keys = { }
  }
}
