-- Toggle Background
vim.keymap.set('n', '<M-t>', function()
    if vim.o.background == "light" then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end
end, { noremap = true, silent = true })
