return {
  {
    "Yagua/nebulous.nvim",
    lazy = false,
    priority = 1000,
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
        -- custom_colors = { -- this table can hold any group of colors with their respective values
        --   LineNr = { fg = "#5BBBDA", bg = "NONE", style = "NONE" },
        --   CursorLineNr = { fg = "#E1CD6C", bg = "NONE", style = "NONE" },
        --
        --   -- it is possible to specify only the element to be changed
        --   TelescopePreviewBorder = { fg = "#A13413" },
        --   LspDiagnosticsDefaultError = { bg = "#E11313" },
        --   TSTagDelimiter = { style = "bold,italic" },
        -- }
      })
    end,
  }
}
