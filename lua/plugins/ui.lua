return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
            {
              "aerial",
              -- The number of symbols to render top-down. In order to render only 'N' last
              -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
              -- be used in order to render only current symbol.
              depth = 4,

              -- When 'dense' mode is on, icons are not rendered near their symbols. Only
              -- a single icon that represents the kind of current symbol is rendered at
              -- the beginning of status line.
              dense = false,

              -- The separator to be used to separate symbols in dense mode.
              dense_sep = ".",

              -- Color the symbol icons.
              colored = true,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
          },
          lualine_y = {
            "diff",
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
        },
        extensions = { "lazy" },
      }
    end,
  },
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    name = "ibl",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        highlight = {"Whitespace"},
        -- char = "▏",
        char = "",
        smart_indent_cap = true,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "fugitive",
        }
      },
      scope = {
        enabled = true,
        highlight = {"Function", "Label"},
        show_start = true,
        show_end = true,
        priority = 500,
        char = "▏",
        show_exact_scope = true,
      },
    },
    config = function (_, opts)
      return require('ibl').setup(opts)
    end
  },
  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    opts = {
      symbol = "┇",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "winston0410/range-highlight.nvim",
    dependencies = {
      "winston0410/cmd-parser.nvim"
    },
    lazy = false,
    opts = {},
  },

  -- Show a previous/next buffers when navigating between buffers
  {
    "ghillb/cybu.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
    opts = {
      position = {
        -- relative_to = "cursor",
        anchor = "centerleft",
        max_win_height = 15
      },
      display_time = 1500,
    },
    keys = {
      { "[b", "<Plug>(CybuPrev)", desc = "Prev buffer" },
      { "]b", "<Plug>(CybuNext)", desc = "Next buffer" },
    }
  },
  {
    "https://gitlab.com/yorickpeterse/nvim-window",
    opts = {
      normal_hl = 'Todo',
      hint_hl = 'Bold',
      border = 'none'
    },
    keys = {
      {
        "<A-w>",
        function() require("nvim-window").pick() end,
        mode = { "n", "i" },
      }
    }
  }
}
