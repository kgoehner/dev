-- Toggle Background
vim.keymap.set('n', '<M-t>', function()
    if vim.o.background == "light" then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end
end, { noremap = true, silent = true })

-- Yank full path to system clipboard
vim.keymap.set('n', '<leader>yp', ":let @+ = expand('%:p')<CR>", { desc = 'Yank full path' })

-- Yank relative path to system clipboard
vim.keymap.set('n', '<leader>yr', ":let @+ = expand('%')<CR>", { desc = 'Yank relative path' })
