local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

require 'angshuman.lsp.configs'
require('angshuman.lsp.handlers').setup()
require 'angshuman.lsp.null-ls'
