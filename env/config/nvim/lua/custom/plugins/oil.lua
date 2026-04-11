vim.pack.add({ 'https://github.com/echasnovski/mini.icons' }, { load = true })
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' }, { load = true })
---@module 'oil'
---@type oil.SetupOpts
require('oil').setup({
  view_options = {
    show_hidden = true,
  },
})
