local strings = require("utils.strings");

local function SetupBindings()
    -- Map leader key - <Space>
    vim.g.mapleader = " "
    -- Map some localleader key (IDK what is it) - <\>
    vim.g.maplocalleader = "\\"
    -- Complete menu options
    vim.opt.completeopt = "menu,menuone,noselect,fuzzy"
    -- Show complete menu on <Space + e> hotkey
    vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)

    -- Autogroup for lsp events
    local configLspGroup = vim.api.nvim_create_augroup("config.lsp", { clear = true })
    -- Setup bindings associated with lsp for specific buffers
    -- LspAttach triggered when LSP client initialize and attaches to buffer
    vim.api.nvim_create_autocmd("LspAttach", {
        group = configLspGroup,
        callback = function(args)
            -- LSP client of this buffer
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "No associated client_id for lsp command")
            -- If client supports completion
            -- -- Enable completion menu autotrigger
            -- -- Enable <Ctrl + Space> hotkey -> Show completion
            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

                vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end, { buffer = args.buf })
            end

            -- If client supports formatting
            -- -- Enable <Space + Space + f> hotkey - Autoformat
            if client:supports_method('textDocument/formatting') then
                vim.keymap.set("n", "<Leader><Leader>f",
                    function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 }) end,
                    { buffer = args.buf }
                )
            end
        end
    })


    -- Autogroup for hightlight commands
    local hightlightGroup = vim.api.nvim_create_augroup("highlight", { clear = true })
    -- Hightlight text on copy
    vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Hightlight yanked text",
        group = hightlightGroup,
        callback = function()
            vim.hl.on_yank();
        end
    })

    -- Keymap for clear search highlight
    -- Abbreviation: <Leader> - No (n) - Highlight (h)
    vim.keymap.set({"n", "v"}, "<Leader>nh", ":nohlsearch<CR>");

    -- Remap x (cut) - Delete a single character without yank
    vim.keymap.set("n", "x", "\"_x");
    -- Remap d (delete) - Delete without yank
    vim.keymap.set("n", "d", "\"_d");
    vim.keymap.set("n", "D", "\"_D");
    vim.keymap.set("n", "dd", "\"_dd");
    vim.keymap.set("v", "d", "\"_d");

    -- Commands to execute pieces of lua script
    --
    -- Autogroup for .lua file extension
    local configLuaGroup = vim.api.nvim_create_augroup("config.filetype.lua", { clear = true });
    -- Register commands execution for new created buffer
    vim.api.nvim_create_autocmd("BufNew", {
        group = configLuaGroup,
        callback = function(opts)
            -- Should be .lua file extension
            if not strings.ends_with(opts.file, ".lua") then
               return
            end

            -- Execute whole file
            vim.keymap.set("n", "<Leader><Leader>x", function()
               local filepath = vim.api.nvim_buf_get_name(0)
               vim.api.nvim_command("source " .. filepath)
               print("Executed: " .. filepath)
            end);
            -- Execute one line (in normal mode)
            vim.keymap.set("n", "<Leader>x", ":.lua<CR>");
            -- Execute manu lines (in visual mode)
            vim.keymap.set("v", "<Leader>x", ":lua<CR>");
        end
    });
end

return {
    Configure = function()
        SetupBindings();
    end
}
