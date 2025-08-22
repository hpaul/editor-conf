return {
  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
        "size",
        -- "birthtime",
        "mtime",
      },
      win_options = {
        wrap = false,
        signcolumn = "yes:2",
        cursorcolumn = false,
        spell = false,
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        natural_order = false,
        sort = {
          { "type", "asc" },
          { "birthtime", "asc" },
          { "mtime", "asc" }
        }
      },
    },
    keys = function()
      return {
        { "-", ":lua require('oil').open()<cr>", desc = "Open parent directoy" },
      }
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {
      highlights = {
        OilGitAdded = { fg = "#a6e3a1" },     -- green
        OilGitModified = { fg = "#f9e2af" },  -- yellow  
        OilGitDeleted = { fg = "#f38ba8" },   -- red
        OilGitRenamed = { fg = "#cba6f7" },   -- purple
        OilGitUntracked = { fg = "#89b4fa" }, -- blue
        OilGitIgnored = { fg = "#6c7086" },   -- gray
      }
    }
  }
}
