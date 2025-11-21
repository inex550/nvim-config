-- My nvim key bindings

local function SetupLsp()
    vim.opt.completeopt = "menu,menuone,noselect,fuzzy"

    vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float)

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
        callback = function(args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

                vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end, { buffer = args.buf })
            end

            if client:supports_method('textDocument/formatting') then
                vim.keymap.set("n", "<Leader><Leader>f",
                    function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 }) end,
                    { buffer = args.buf }
                )
            end
        end
    })
end

-- Bind default autocmd's
-- They don't change anything, just highlight some stuff i like
local function BindDefaultAutoCmds()
    vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Hightlight yanked text",
        group = vim.api.nvim_create_augroup("highlight-onYank", { clear = true }),
        callback = function()
            vim.hl.on_yank()
        end
    })
end

-- Setup my default bindings
local function BindDefaultKeymaps()
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    vim.keymap.set("n", "<Leader><Leader>x", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        vim.api.nvim_command("source " .. filepath)
        print("Executed: " .. filepath)
    end);
    vim.keymap.set("n", "<Leader>x", ":.lua<CR>");
    vim.keymap.set("v", "<Leader>x", ":lua<CR>");
end

return {
    Configure = function()
        BindDefaultKeymaps()
        BindDefaultAutoCmds()
        SetupLsp()
    end
}
