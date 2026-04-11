-- Lazy-load on first insert
vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' }, { load = true })
    require('nvim-autopairs').setup()
  end,
})
