-- Style configuration functions
-- Just some functions to setup some shiny stuff

local function SetupIndents(opts)
    vim.opt.expandtab = opts.useSpaces
    vim.opt.tabstop = opts.indentSize
    vim.opt.shiftwidth = opts.indentSize
end

local function ShowLineNumbers(enable)
    vim.opt.number = enable
end

local function SetupFonts()
    vim.opt.guifont =  { "0xProto Nerd Font" }
end

return {
    Configure = function()
        SetupIndents({ useSpaces = true, indentSize = 4 })
        ShowLineNumbers(true)
        SetupFonts()
    end
}

