return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = {},
      },
    },
    setup = {
      ruff = function()
        require("lazyvim.util").on_attach(function(client, _)
          if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            -- client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
  {
    "neolooong/whichpy.nvim",
    dependencies = {},
    opts = {},
  },
}
