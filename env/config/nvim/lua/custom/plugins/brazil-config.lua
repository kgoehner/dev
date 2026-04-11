local work = require('utils.work')

if not work.is_work_machine() then return end

vim.pack.add({ { src = 'ssh://git.amazon.com/pkg/NinjaHooks', version = 'mainline', name = 'NinjaHooks' } }, { load = true })
local brazil_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/NinjaHooks/configuration/vim/amazon/brazil-config'
vim.opt.rtp:prepend(brazil_path)
vim.cmd('runtime! ' .. brazil_path .. '/ftdetect/*.vim')
vim.cmd('runtime! ' .. brazil_path .. '/plugin/*.vim')
vim.cmd('runtime! ' .. brazil_path .. '/plugin/*.lua')
