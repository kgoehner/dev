local ok, fzf = pcall(require, "fzf-lua")
if not ok then return end

vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "Fzf Files" })
vim.keymap.set("n", "<C-m>", fzf.git_status, {})
vim.keymap.set("n", "<leader>ps", function()
  fzf.grep({prompt="Grep > "});
end)
