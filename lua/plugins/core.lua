require("lazyvim.config").init()

return {
  {
    "folke/lazy.nvim",
    version = "*",
  },
  {
    -- measure startuptime and intialize
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    priority = 10000, lazy = false, cond = true, version = "*",
    config = function(_, opts)
      vim.g.startuptime_tries = 10
      opts = opts or {}
      require("lazyvim.config").setup(opts)
      -- Change color scheme to one which is great by default
      -- vim.cmd [[ colorscheme slate ]]
      -- vim.cmd [[ hi WinSeparator ctermbg=none cterm=none ctermfg=none ]]
    end,
  }
}
