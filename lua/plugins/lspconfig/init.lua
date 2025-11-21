return {
    "neovim/nvim-lspconfig",

    config = function()
        local configsModule = "plugins.lspconfig.per-language"

        require(configsModule .. ".lua").Configure()
        require(configsModule .. ".clangd").Configure()
        require(configsModule .. ".cmake").Configure()
        require(configsModule .. ".nix").Configure()
        require(configsModule .. ".bash").Configure()
    end
}
