return {
  'stevearc/oil.nvim',
  opts = {
    columns = {
      "icon",
      "size",
      "mtime"
    },
    win_options = {
      wrap = false,
      signcolumn = "yes",
      cursorcolumn = false,
      spell = false,
    },
    default_file_explorer = true,
    view_options = {
      show_hidden = true
    }
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
