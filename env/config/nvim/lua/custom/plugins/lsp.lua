vim.pack.add({ 'https://github.com/williamboman/mason.nvim' }, { load = true })
vim.pack.add({ 'https://github.com/williamboman/mason-lspconfig.nvim' }, { load = true })
vim.pack.add({ 'https://github.com/mfussenegger/nvim-jdtls' }, { load = true })
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' }, { load = true })

require('mason').setup()

-- lazydev: only load on lua files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/folke/lazydev.nvim' }, { load = true })
    require('lazydev').setup({
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    })
  end,
})

local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  jdtls = {},
  zk = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local fzf = require('fzf-lua')
    map('gd', fzf.lsp_definitions, '[G]oto [D]efinition')
    map('gr', fzf.lsp_references, '[G]oto [R]eferences')
    map('gI', fzf.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', fzf.lsp_typedefs, 'Type [D]efinition')
    map('<leader>ds', fzf.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', fzf.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
end
vim.lsp.enable(vim.tbl_keys(servers))
