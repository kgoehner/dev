local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "Fzf Files" })
vim.keymap.set("n", "<C-m>", fzf.git_status, {})
vim.keymap.set("n", "<leader>ps", function()
  fzf.grep({prompt="Grep > "});
end)
