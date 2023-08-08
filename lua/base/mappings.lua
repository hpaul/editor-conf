local keymap = vim.keymap

-- Move vertically by visual line
keymap.set("n", "j", "gj", { desc = "Move vertically by visual line", noremap = true })
keymap.set("n", "k", "gk", { desc = "Move vertically by visual line", noremap = true })

-- With this you can use >< multiple time for changng indent when you visual selected text.
keymap.set("v", "<", "<gv", { noremap = true })
keymap.set("v", ">", ">gv", { noremap = true })

-- Keymap for adding space lines below and above the cursor
vim.cmd [[
nnoremap <silent> ]<Space> :<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>
]]

-- Paste over currently selected text without yanking it
keymap.set("v", "p", '"_dP', { noremap = true })
keymap.set("v", "P", '"_dP', { noremap = true })

-- Abbreviations
vim.cmd [[
  cmap Qa qa
  cmap Wa Wa
  cmap WQ wq
  cmap Wq wq
  cmap Qa1 qa!
  cmap QA1 qa!
]]
-- Leader shortcuts

-- Switch windows
keymap.set({ "n", "i", "x" }, "<M-h>", "<C-W>h")
keymap.set({ "n", "i", "x" }, "<M-j>", "<C-W>j")
keymap.set({ "n", "i", "x" }, "<M-k>", "<C-W>k")
keymap.set({ "n", "i", "x" }, "<M-l>", "<C-W>l")

-- Resize window using ALT + 1/0 for left and right and ALT + 6/7 for up and down
vim.cmd [[
nnoremap <M-1> :exe "vertical resize " . (winwidth(0) - 5)<CR>
nnoremap <M-0> :exe "vertical resize " . (winwidth(0) + 5)<CR>

nnoremap <M-6> :exe "resize " . (winheight(0) - 5)<CR>
nnoremap <M-7> :exe "resize " . (winheight(0) + 5)<CR>
]]


-- Highlight the terminal cursor
vim.cmd [[
  hi! link TermCursor Cursor
  hi TermCursorNC ctermfg=235 ctermbg=242 guifg=#002b36 guibg=#586e75 guisp=NONE cterm=NONE gui=NONE
]]

-- ToggleTerm
local function set_terminal_keymaps()
  -- Keep maximum 10000 lines into the terminal buffer
  vim.opt.scrollback = 10000

  keymap.set("t", "<esc>", "<c-\\><c-n>", { noremap = true })
  keymap.set("t", "<M-h>", "<c-\\><c-n><c-w>h", { noremap = true })
  keymap.set("t", "<M-j>", "<c-\\><c-n><c-w>j", { noremap = true })
  keymap.set("t", "<M-k>", "<c-\\><c-n><c-w>k", { noremap = true })
  keymap.set("t", "<M-l>", "<c-\\><c-n><c-w>l", { noremap = true })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
})
