return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'leoluz/nvim-dap-go',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'mxsdev/nvim-dap-vscode-js',
        {
            "microsoft/vscode-js-debug",
            lazy = true,
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        }
    },
    config = function()
        local dap = require('dap')
        local dap_go = require('dap-go')
        local dap_ui = require('dapui')
        local dap_virtual_text = require('nvim-dap-virtual-text')

        vim.keymap.set('n', "<leader>dc", dap.continue)
        vim.keymap.set('n', "<leader>ds", dap.step_over)
        vim.keymap.set('n', "<leader>dS", dap.step_out)
        vim.keymap.set('n', "<leader>di", dap.step_into)
        vim.keymap.set('n', "<leader>dt", dap.toggle_breakpoint)
        vim.keymap.set('n', "<leader>db", function() dap.set_breakpoint(vim.fn.input('Conditional breakpoint: ')) end)
        vim.keymap.set('n', "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message:')) end)
        vim.keymap.set('n', "<leader>dr", dap.repl.open)
        vim.keymap.set('n', "<leader>dT", dap_go.debug_test)

        dap_virtual_text.setup()
        dap_go.setup()
        dap_ui.setup()

        require("dap-vscode-js").setup({
            debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
            -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
            debugger_cmd = { "js-debug-adapter" },                                                       -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
            -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
            -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
        })

        for _, language in ipairs({ "typescript", "javascript" }) do
            require("dap").configurations[language] = {
                {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require 'dap.utils'.pick_process,
                        cwd = "${workspaceFolder}",
                    }
                }
            }
        end

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dap_ui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dap_ui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dap_ui.close()
        end
    end
}
