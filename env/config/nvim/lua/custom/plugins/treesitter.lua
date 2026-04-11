vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' }, { load = true })
-- [[ Configure Treesitter ]]
-- nvim-treesitter v1 is a parser manager; highlighting is built into nvim 0.12
-- Use :TSInstall <lang> / :TSUpdate to manage parsers
require('nvim-treesitter').setup()

-- Enable treesitter-based highlighting and indentation for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local ok = pcall(vim.treesitter.start, ev.buf)
    if ok then
      vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end
  end,
})
