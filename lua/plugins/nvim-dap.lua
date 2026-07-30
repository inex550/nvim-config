local dapAdapter_gdb = {
    type = "executable",
    command = "gdb",
    args = {
        "--interpreter=dap",
    }
}


local dapConf_C = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            local dap = require("dap")

            local programToDebug = nil

            vim.ui.input({ prompt = "Path to executable: ", default = vim.fn.getcwd() .. "/.build/", completion = "file"}, function(input)
                programToDebug = input
            end)

            if not programToDebug then
                print("Program wasn't specified")
                return dap.ABORT
            end

            return programToDebug
        end,
        args = {},
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false
    }
}

local dapConf_Cpp = dapConf_C


return {
    'mfussenegger/nvim-dap',
    tag = '0.10.0',

    config = function()
        local dap = require('dap')

        vim.keymap.set('n', '<leader>dd', dap.toggle_breakpoint, { desc = 'Debugger: Toggle breakpoint' })
        vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debugger: Continue execution' })
        vim.keymap.set('n', '<leader>ds', dap.step_into, { desc = 'Debugger: Step into' })
        vim.keymap.set('n', '<leader>da', dap.step_over, { desc = 'Debuggr: Step over' })
        vim.keymap.set('n', '<leader>dq', dap.step_over, { desc = 'Debuggr: Step out' })

        dap.adapters.gdb = dapAdapter_gdb

        dap.configurations.c = dapConf_C
        dap.configurations.cpp = dapConf_Cpp
    end
}
