return {
    Configure = function()
        vim.lsp.config.clangd = {
            cmd = {
                'clangd',
                '--header-insertion=never',
            }
        }

        vim.lsp.enable("clangd")
    end
}
