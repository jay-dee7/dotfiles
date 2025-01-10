return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'leoluz/nvim-dap-go',
		'rcarriga/nvim-dap-ui',
		'theHamsta/nvim-dap-virtual-text',
		'nvim-neotest/nvim-nio',
	},
	config = function()
		local dap = require('dap')
		local dap_go = require('dap-go')
		local dap_ui = require('dapui')
		local dap_virtual_text = require('nvim-dap-virtual-text')

		vim.keymap.set('n', '<leader>dc', dap.continue)
		vim.keymap.set('n', '<leader>d?', function() dap_ui.eval(nil, { enter = true }) end)
		vim.keymap.set('n', '<leader>ds', dap.step_over)
		vim.keymap.set('n', '<leader>dS', dap.step_out)
		vim.keymap.set('n', '<leader>di', dap.step_into)
		vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
		vim.keymap.set('n', '<leader>db', function()
			dap.set_breakpoint(vim.fn.input('Conditional breakpoint: '))
		end)
		vim.keymap.set('n', '<leader>dl', function()
			dap.set_breakpoint(nil, nil, vim.fn.input('Log point message:'))
		end)
		vim.keymap.set('n', '<leader>dr', dap.repl.open)
		vim.keymap.set('n', '<leader>dT', dap_go.debug_test)

		dap_virtual_text.setup()
		dap_go.setup()
		dap_ui.setup()

		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-vscode",
			name = "lldb",
		}

		dap.configurations.zig = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = "${workspaceFolder}/zig-out/bin/${workspaceFolder}",
				cwd = "${workspaceFolder}",
				args = {},
			}
		}

		dap.listeners.before.attach.dapui_config = function()
			dap_ui.open();
		end
		dap.listeners.before.launch.dapui_config = function()
			dap_ui.open();
		end
		dap.listeners.before.event_terminated['dapui_config'] = function()
			dap_ui.close()
		end
		dap.listeners.before.event_exited['dapui_config'] = function()
			dap_ui.close()
		end
	end,
}
