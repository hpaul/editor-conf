require("lazyvim.config").init()

return {
  { "folke/lazy.nvim", version = "*" },
  {
    -- measure startuptime and intialize
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    priority = 10000, lazy = false, cond = true, version = "*",
    config = function(_, opts)
      vim.g.startuptime_tries = 10
      opts = opts or {}
      require("lazyvim.config").setup(opts)
    end,
  }
} 
