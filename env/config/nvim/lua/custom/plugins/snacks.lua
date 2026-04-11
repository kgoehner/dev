vim.pack.add({ 'https://github.com/folke/snacks.nvim' }, { load = true })

---@type snacks.Config
require('snacks').setup({
  notifier = { enabled = true },
  scope = { enabpled = true },
  statuscolumn = {
    enabled = true,
    folds = {
      git_hl = true,
    },
  },
  gitbrowse = {
    notify = true,
    remote_patterns = {
      { '^(https?://.*)%.git$'                , '%1' },
      { '^git@(.+):(.+)%.git$'                , 'https://%1/%2' },
      { '^git@(.+):(.+)$'                     , 'https://%1/%2' },
      { '^git@(.+)/(.+)$'                     , 'https://%1/%2' },
      { '^ssh://git@(.*)$'                    , 'https://%1' },
      { '^ssh://git.amazon.com:2222/pkg/(.*)$', 'code.amazon.com/packages/%1' },
      { '^ssh://([^:/]+)(:%d+)/(.*)$'         , 'https://%1/%3' },
      { '^ssh://([^/]+)/(.*)$'                , 'https://%1/%2' },
      { 'ssh%.dev%.azure%.com/v3/(.*)/(.*)$'  , 'dev.azure.com/%1/_git/%2' },
      { '^https://%w*@(.*)'                   , 'https://%1' },
      { '^git@(.*)'                           , 'https://%1' },
      { ':%d+'                                , '' },
      { '%.git$'                              , '' },
    },
    url_patterns = {
      ['github%.com'] = {
        branch = '/tree/{branch}',
        file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
        commit = '/commit/{commit}',
      },
      ['gitlab%.com'] = {
        branch = '/-/tree/{branch}',
        file = '/-/blob/{branch}/{file}#L{line_start}-L{line_end}',
        commit = '/-/commit/{commit}',
      },
      ['bitbucket%.org'] = {
        branch = '/src/{branch}',
        file = '/src/{branch}/{file}#lines-{line_start}-L{line_end}',
        commit = '/commits/{commit}',
      },
      ['code.amazon%.com'] = {
        branch = '/trees/heads/{branch}',
        file = '/blobs/{branch}/--/{file}#L{line_start}-L{line_end}',
        commit = '/commits/{commit}',
      },
    },
  },
})

-- Keymaps
vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
vim.keymap.set('n', '<leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
vim.keymap.set('n', '<leader>tt', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gL', function() Snacks.lazygit.log() end, { desc = 'Lazygit' })

-- Deferred setup (debug globals + toggles)
vim.schedule(function()
  _G.dd = function(...) Snacks.debug.inspect(...) end
  _G.bt = function() Snacks.debug.backtrace() end
  vim.print = _G.dd -- Override print to use snacks for `:=` command

  -- Create some toggle mappings
  Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tL')
  Snacks.toggle.line_number():map('<leader>ul')
  Snacks.toggle.inlay_hints():map('<leader>th')
  Snacks.toggle.indent():map('<leader>tg')
  Snacks.toggle.dim():map('<leader>tD')
  Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>tb')
end)
