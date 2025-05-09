local load_textobjects = true
return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- Until I find a better place
          -- make zsh files recognized as sh for bash-ls & treesitter
          vim.filetype.add {
            extension = {
              zsh = "sh",
              sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
            },
            filename = {
              [".zshrc"] = "sh",
              [".zshenv"] = "sh",
              [".envrc"] = "sh",
            },
          }
          -- disable rtp plugin, as we only need its queries for mini.ai
          -- In case other textobject modules are enabled, we will load them
          -- once nvim-treesitter is loaded
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          load_textobjects = true
        end,
      },
      { "windwp/nvim-ts-autotag" }
    },
    cmd = { "TSUpdateSync" },
    keys = {
      { "<cr>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "css",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "glimmer",
        "erlang",
        "elixir",
        "heex",
        "eex",
        "ruby",
        "graphql",
        "prisma",
        "commonlisp",
        "typespec",
        "astro"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      autotag = {
        enable = true
      },
      textobjects = {
        select = {},
        swap = {
          enable = false,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
          },
        },
        lsp_interop = {
          border = "single",
          enable = true,
          floating_preview_opts = {},
          peek_definition_code = {
            ["gp"] = "@function.outer",
            ["gP"] = "@class.outer",
          },
        },
      }
    },
    ---@param opts TSConfig
    config = function(_, opts)
      -- Register the mdx filetype
      vim.filetype.add({ extension = { mdx = "mdx" } })

      -- Configure treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register("markdown", "mdx")

      -- If the current buffer has the extension mdx, but not the newly create filetype, set it
      if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
        vim.o.filetype = "mdx"
      end

      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)

      if load_textobjects then
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require("lazy.core.loader")
              Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
              local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
              require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
              break
            end
          end
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 12, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 3, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = '─',
      zindex = 20, -- The Z-index of the context window
      on_attach = function(buf)  -- (fun(buf: integer): boolean) return false to disable attaching}
        return true
      end,
    },
    keys = {
      {
        "[c",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        mode = "n",
        desc = "Go to context",
      }
    }
  },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>m', function() require('treesj').toggle() end, },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        max_join_length = 300,
      })
    end,
  },
  -- {
  --   "https://gitlab.com/HiPhish/jinja.vim",
  --   lazy = false,
  --   config = function()
  --     vim.cmd [[ autocmd! BufRead,BufNewFile *.html  call jinja#AdjustFiletype() ]]
  --   end
  -- }
}
