return {
  {
    "Yagua/nebulous.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      require("nebulous").setup({
        variant = "fullmoon",
        disable = {
          background = false,
          endOfBuffer = false,
          terminal_colors = true
        },
        italic = {
          comments   = true,
          keywords   = true,
          functions  = false,
          variables  = true,
        },
        custom_colors = { -- this table can hold any group of colors with their respective values
          -- it is possible to specify only the element to be changed
          TelescopePreviewBorder = { fg = "#A13413" },
          LspDiagnosticsDefaultError = { bg = "#E11313" },
        }
      })
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    enabled = false,
    config = function ()
      require('material').setup({
        contrast = {
          terminal = true, -- Enable contrast for the built-in terminal
          sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false, -- Enable contrast for floating windows
          cursor_line = false, -- Enable darker background for the cursor line
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { italic = true },
          strings = { },
          keywords = { --[[ underline = true ]] },
          functions = { },
          variables = {},
          operators = {},
          types = {},
        },

        plugins = {
          -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "dap",
          -- "dashboard",
          "gitsigns",
          -- "hop",
          "indent-blankline",
          -- "lspsaga",
          "mini",
          -- "neogit",
          -- "neorg",
          "nvim-cmp",
          -- "nvim-navic",
          -- "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          -- "trouble",
          -- "which-key",
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false -- Hide the end-of-buffer lines
        },

        high_visibility = {
          lighter = true, -- Enable higher contrast text for lighter style
          darker = false -- Enable higher contrast text for darker style
        },

        lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

        async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_colors = nil, -- If you want to override the default colors, set this to a function

        custom_highlights = {}, -- Overwrite highlights with your own
      })

      vim.g.material_style = "lighter"
      vim.cmd [[ colorscheme material ]]
    end
  }
}
