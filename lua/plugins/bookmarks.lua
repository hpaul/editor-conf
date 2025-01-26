return {
  {
    "MattesGroeger/vim-bookmarks",
    lazy = false,
    init = function()
      vim.cmd [[
        highlight BookmarkSign ctermbg=NONE ctermfg=160
        highlight BookmarkLine ctermbg=194 ctermfg=NONE
        let g:bookmark_sign = '⚑'
        let g:bookmark_highlight_lines = 1
        let g:bookmark_save_per_working_dir = 1
        let g:bookmark_auto_save = 1
        let g:bookmark_display_annotation = 1
      ]]
    end
  },

  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    dependencies = {
      "MattesGroeger/vim-bookmarks"
    },
    keys = {
      {
        "<leader>sb",
        "<cmd>Telescope vim_bookmarks all<cr>",
        desc = "Search through all project bookmarks"
      },
      {
        "<leader>sB",
        "<cmd>Telescope vim_bookmarks current_file<cr>",
        desc = "Search through buffer bookmarks"
      }
    }
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
    require("telescope").load_extension("vim_bookmarks")
  end,
}
