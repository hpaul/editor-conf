---@diagnostic disable: assign-type-missmatch
-- Defining alias for opt
local opt = vim.opt

-- Custom settings
opt.compatible = false
-- Set leader command to comma
vim.g.mapleader = ","

-- UI config
opt.number = true -- Show line number
opt.numberwidth = 1 -- How many columns should line number take
opt.relativenumber = false -- Show line number relative to the current line
opt.cursorline = true -- highlight current line
opt.lazyredraw = true -- redraw only when need to
opt.showmatch = true -- highlight matching [{()}]
opt.incsearch = true -- search as characters are netered
opt.hlsearch = true -- highlight searches
opt.ignorecase = true -- do case insensitive matching
opt.smartcase = true --- ..except when using capital letters
opt.hidden = true -- allow hidden buffers
opt.termguicolors = true -- enable support for terminal colors
opt.scrolloff = 5 -- show 5 more lines after the current line
opt.confirm = true -- show confirm dialog on close
--
-- Set signcolumn width to 3.
opt.signcolumn = "yes"

-- Enable clipboard.
opt.clipboard = "unnamedplus"

-- Prefer already opened splits when opening a buffer
opt.switchbuf = "useopen"

-- Show completion menu even for one item and do not autoselect the first one
opt.completeopt = "menuone,noselect"
-- Decrease time of completion menu.
opt.updatetime = 50

opt.cmdwinheight = 7 -- maximum height of the command window
opt.colorcolumn = { "120" } -- color columns at these offsets

-- splits open below an to the right
opt.splitbelow = true
opt.splitright = true

-- show invisible characters
opt.list = true
opt.listchars = "tab:>\\,trail:·,nbsp:+,eol:↵"

opt.softtabstop = 2 -- set tab size
opt.shiftwidth = 2 -- affect amount of indentation
opt.expandtab = true -- set that tab will insert softabstop amount of space characters
opt.smartindent = true
-- Indents word-wrapped lines as much as the 'parent' line
opt.breakindent = true
-- Ensures word-wrap does not split words
opt.formatoptions = 'l'
opt.linebreak = true
-- Folding
opt.foldenable = true -- enable folding
opt.foldlevelstart = 10 -- open most folds by default
opt.foldnestmax = 10 -- 10 nested fold max
opt.foldmethod = "syntax"

-- Backups
opt.writebackup = true

-- Set the colorscheme variant to monochrome
-- vim.cmd('colorscheme zephyr')

-- change scrolling speed
opt.scroll = 15

-- Ensure that vim searches everywhere in the current path
vim.opt.path:append("**")

-- Spelling
opt.spelloptions = 'camel'
vim.cmd [[language en_US.UTF-8]]

-- Highlight yanked text
vim.cmd([[
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
]])

-- Disable syntax highlighting
--
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
        " exec 'TSBufDisable textobjects.move'
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
