return {
  {
    "nvim-lspconfig",
    lazy = false,
    opts = function()
      -- create new neovim command which receives as first argument a feature flag name
      -- and a second argument a value of on/off 
      -- it sets makrprg to l local cleanup script with both arguments
      -- also sets errorformat opt to parse eslint compact format
      -- then it resets the makeprg and errorformat to the values before
      -- Remember original makeprg and errorformat values
      local original_makeprg = vim.opt.makeprg:get()
      local original_errorformat = vim.opt.errorformat:get()

      -- Create a new command named "CleanupFeatureFlag"
      vim.api.nvim_create_user_command("CleanupFeatureFlag", function(opts)
        local feature_flag = opts.args:match("^(%S+)")
        local value = opts.args:match("%s+(%S+)$")

        if not feature_flag or not value then
          print("Usage: :CleanupFeatureFlag <feature_flag> <on|off>")
          return
        end

        -- Set makeprg and errorformat options
        vim.opt.makeprg = "./cleanup/featureflag.sh " .. feature_flag .. " " .. value .. " --vimgrep"
        vim.opt.errorformat = "%f: line %l\\, col %c\\, %m,%-G%.%#"

        -- Run make
        vim.cmd("make")

        -- Reset makeprg and errorformat options to original values
        vim.opt.makeprg = original_makeprg
        vim.opt.errorformat = original_errorformat
      end, { nargs = "+" })
    end
  },
  {
    "nvim-lspconfig",
    lazy = false,
    init = function()
      function FoldOthers()
        -- Get current line and fold level
        local current_line = vim.fn.line('.')
        local current_fold_level = vim.fn.foldlevel(current_line)

        -- Skip if we're on a line with no fold level
        if current_fold_level == 0 then
          return
        end

        -- Store view to restore cursor position later
        local view = vim.fn.winsaveview()

        -- Close all folds
        vim.cmd('normal! zM')

        -- Open folds until we reach our line
        vim.cmd(current_line .. 'normal! zv')

        -- Restore cursor position and center the view
        vim.fn.winrestview(view)
        vim.cmd('normal! zz')
      end 
      -- Optional: Set up a keybinding
      vim.keymap.set('n', 'zO', FoldOthers, {
        noremap = true,
        silent = true,
        desc = "Close all other folds and keep the one active where the cursor is",
      })
    end,
  }
}
