vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' }, { load = true })
vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' }, { load = true })
require('todo-comments').setup({ signs = false })
