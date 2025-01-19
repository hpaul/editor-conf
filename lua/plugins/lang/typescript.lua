return {

  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.ts_ls
        ts_ls = {
          init_options = {
            hostInfo = 'neovim',
            trace = 'verbose',
            log = "normal",
            logDirectory = '~/.ts_logs',
            logVerbosity = 'normal',
            tsserver = {
              log = "terse",
              logDirectory = "~/.ts_logs",
              maxTsServerMemory = 3072*3,
              trace = "verbose",
            },
          },
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
                placeOpenBraceOnNewLineForControlBlocks = true,
                semicolons = "insert",
                trimTrailingWhitespace = true,
              },
              -- inlayHints = {
              --   includeInlayParameterNameHints = "off",
              --   includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              --   includeInlayFunctionParameterTypeHints = true,
              --   includeInlayVariableTypeHints = true,
              --   includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              --   includeInlayPropertyDeclarationTypeHints = true,
              --   includeInlayFunctionLikeReturnTypeHints = true,
              --   includeInlayEnumMemberValueHints = true,
              -- },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
                placeOpenBraceOnNewLineForControlBlocks = true,
                semicolons = "insert",
                trimTrailingWhitespace = true,
              },
              -- inlayHints = {
              --   includeInlayParameterNameHints = "off",
              --   includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              --   includeInlayFunctionParameterTypeHints = true,
              --   includeInlayVariableTypeHints = true,
              --   includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              --   includeInlayPropertyDeclarationTypeHints = true,
              --   includeInlayFunctionLikeReturnTypeHints = true,
              --   includeInlayEnumMemberValueHints = true,
              -- },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      -- table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    end,
  },
}
