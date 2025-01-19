return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "nim",
          "nim_format_string",
          "c",
          "zig"
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { },
    },
  },
}

