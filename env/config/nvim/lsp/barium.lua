vim.lsp.config.lua = {
    cmd = { 'barium' },
    root_markers = { 'Config' },
    filetypes = { 'brazil-config' },
}

-- Enable Barium
vim.lsp.enable("barium")
