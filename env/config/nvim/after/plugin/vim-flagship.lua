--vim.api.nvim_create_autocmd("User", {
--    pattern = "Flags",
--    callback = function() vim.api.nvim_call_function("Hoist", { "buffer", "fugitive#statusline" }) end,
--})
--
--vim.api.nvim_create_autocmd("User", {
--    pattern = "Flags",
--    callback = function() vim.api.nvim_call_function("Hoist", { "global", "%{&ignorecase ? '[IC]' : ''}" }) end,
--})

--vim.cmd [[
--    autocmd User Flags call g:Hoist("buffer", "fugitive#statusline")
--]]

vim.g["tablabel"] = "%N%{flagship#tabmodified()} %{flagship#tabcwds('shorten',',')}"
