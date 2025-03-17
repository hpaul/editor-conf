-- This file is automatically loaded by plugins.core
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Show * markup for bold and italic
opt.concealcursor = 'nic' -- Show concealed elements when edidting and selecting
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "joqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
--opt.listchars = "tab:>\\,trail:·,nbsp:+,eol:↵"
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.numberwidth = 1 -- How many columns should line number take
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "winpos", "help" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, S = false })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 5 -- Columns of context
opt.wrap = false -- Enable line wrap
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartindent = true -- Insert indents automatically
opt.breakindent = true -- Indents word-wrapped lines as much as the 'parent' line
opt.spelllang = "en,ro"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
-- opt.timeoutlen = 300 -- We're thinking about it
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "list,full" -- Command-line completion mode
opt.winminwidth = 4 -- Minimum window width
opt.compatible = false -- Disable old compatibility
opt.lazyredraw = true -- redraw only when need to
opt.showmatch = false -- highlight matching [{()}]
opt.hlsearch = true -- highlight searches
opt.hidden = true -- allow hidden buffers
opt.scrolloff = 5 -- show 5 more lines after the current line
-- Prefer already opened splits when opening a buffer
opt.switchbuf = "useopen"
-- Decrease time of completion menu.
opt.updatetime = 50
opt.cmdwinheight = 10 -- maximum height of the command window
opt.colorcolumn = { "120" } -- color columns at these offsets
-- splits open below an to the right
opt.splitbelow = true
opt.splitright = true
opt.linebreak = true
opt.startofline = true
opt.statuscolumn = "%C%s%=%T%{v:relnum?v:relnum:v:lnum}│%T"
opt.splitkeep = "cursor"
opt.shortmess:append({ C = true })

-- Folding
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldenable = true -- enable folding
opt.foldlevel = 99
opt.foldlevelstart = 8 -- open most folds by default
opt.foldnestmax = 8 -- 10 nested fold max
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Backups
opt.writebackup = true

-- change scrolling speed
opt.scroll = 15

-- Ensure that vim searches everywhere in the current path
opt.path:append("**")

opt.virtualedit = "block"
opt.title = true

-- Spelling
opt.spelloptions = 'camel'
vim.cmd [[language en_US.UTF-8]]

vim.cmd [[
  function DisableSyntaxTreesitter()
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
        exec 'TSBufDisable incremental_selection'
        exec 'TSBufDisable indent'
        exec 'TSBufDisable playground'
        exec 'TSBufDisable query_linter'
        exec 'TSBufDisable rainbow'
        exec 'TSBufDisable refactor.highlight_definitions'
        exec 'TSBufDisable refactor.navigation'
        exec 'TSBufDisable refactor.smart_rename'
        exec 'TSBufDisable refactor.highlight_current_scope'
        exec 'TSBufDisable textobjects.swap'
        exec 'TSBufDisable textobjects.move'
        exec 'TSBufDisable textobjects.lsp_interop'
        exec 'TSBufDisable textobjects.select'
    endif

    set foldmethod=manual
  endfunction

  augroup BigFileDisable
    autocmd!
    autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
]]

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
