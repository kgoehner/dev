vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' }, { load = true })
vim.pack.add({ { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') } }, { load = true })

---@module 'blink.cmp'
---@type blink.cmp.Config
require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  signature = { enabled = true },
})
