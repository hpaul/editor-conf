local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  -- add blink.compat
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      'mikavilpas/blink-ripgrep.nvim',
      'dmitmel/cmp-digraphs',
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        trigger = {
          show_on_keyword = true,
        },
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before *and* after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },

        -- Disable auto brackets
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = false }, },

        -- Don't select by default, auto insert on selection
        list = {
          max_items = 100,
          selection = { preselect = true, auto_insert = true },
        },

        menu = {
          border = 'shadow',
          draw = {
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", "source_name", gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  return require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                    symbol_map = { Copilot = "", Supermaven = "" },
                  })
                end,
              },
            }
          }
        },
        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = false },

        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = {
            border = 'double'
          }
        },
      },
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'default',

        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },

        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },

        ['<C-space>'] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_and_accept() end
          end,
          'snippet_forward',
          'fallback'
        },
        ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal'
      },

      sources = {
        default = function()
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer', 'digraphs', 'ripgrep' }
          end

          if vim.tbl_contains({ "sql", "mysql", "plsql", "dbui" }, vim.bo.filetype) then
            return { 'dadbod', 'buffer', 'snippets' }
          end

          local default = {
            'lsp',
            'path',
            'buffer',
            "ripgrep",
            'snippets',
          }
          return default
        end,
        providers = {
          dadbod = {
            name = 'vim-dadbod-completion',
            module = 'blink.compat.source'
          },
          digraphs = {
            name = 'digraphs', -- IMPORTANT: use the same name as you would for nvim-cmp
            module = 'blink.compat.source',

            -- all blink.cmp source config options work as normal:
            score_offset = -3,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            --
            -- this is NOT the same as the opts in a plugin's lazy.nvim spec
            opts = {
              -- this is an option from cmp-digraphs
              cache_digraphs_on_start = true,
            },
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              -- For many options, see `rg --help` for an exact description of
              -- the values that ripgrep expects.

              -- the minimum length of the current word to start searching
              -- (if the word is shorter than this, the search will not start)
              prefix_min_len = 3,

              -- The number of lines to show around each match in the preview
              -- (documentation) window. For example, 5 means to show 5 lines
              -- before, then the match, and another 5 lines after the match.
              context_size = 3,

              -- The maximum file size of a file that ripgrep should include in
              -- its search. Useful when your project contains large files that
              -- might cause performance issues.
              -- Examples:
              -- "1024" (bytes by default), "200K", "1M", "1G", which will
              -- exclude files larger than that size.
              max_filesize = "1M",

              -- Specifies how to find the root of the project where the ripgrep
              -- search will start from. Accepts the same options as the marker
              -- given to `:h vim.fs.root()` which offers many possibilities for
              -- configuration. If none can be found, defaults to Neovim's cwd.
              --
              -- Examples:
              -- - ".git" (default)
              -- - { ".git", "package.json", ".root" }
              project_root_marker = ".git",

              -- The casing to use for the search in a format that ripgrep
              -- accepts. Defaults to "--ignore-case". See `rg --help` for all the
              -- available options ripgrep supports, but you can try
              -- "--case-sensitive" or "--smart-case".
              search_casing = "--ignore-case",

              -- (advanced) Any additional options you want to give to ripgrep.
              -- See `rg -h` for a list of all available options. Might be
              -- helpful in adjusting performance in specific situations.
              -- If you have an idea for a default, please open an issue!
              --
              -- Not everything will work (obviously).
              additional_rg_options = {},

              -- When a result is found for a file whose filetype does not have a
              -- treesitter parser installed, fall back to regex based highlighting
              -- that is bundled in Neovim.
              fallback_to_regex_highlighting = true,

              -- Show debug information in `:messages` that can help in
              -- diagnosing issues with the plugin.
              debug = false,

              -- Features that are not yet stable and might change in the future.
              future_features = {
                -- Kill previous searches when a new search is started. This is
                -- useful to save resources and might become the default in the
                -- future.
                kill_previous_searches = true,
              },
            },
            -- (optional) customize how the results are displayed. Many options
            -- are available - make sure your lua LSP is set up so you get
            -- autocompletion help
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(proj)",
                }
              end
              return items
            end,
          },
        }
      },

      snippets = { preset = "default" },
      signature = { enabled = true },

    },
    opts_extend = { "sources.default" }
  },
  {
   'saghen/blink.cmp',
    ft = { "sql", "mysql", "plsql", "dbui" },
  },
  -- auto pairs
  -- 
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    enabled = false,
    opts = {},
  },
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
