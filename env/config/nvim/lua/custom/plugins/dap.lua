return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			local dapy = require("dap-python")
			dapy.setup()

			require("nvim-dap-virtual-text").setup()

			vim.keymap.set("n", "<leader>dbt", dap.toggle_breakpoint, { desc = "[D]ebug [B]reakpoint [T]oggle" })

			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })

			vim.keymap.set("n", "<leader>drm", dapy.test_method, { desc = "[D]ebug [R]run [M]ethod" })
			vim.keymap.set("n", "<leader>drf", dapy.test_class, { desc = "[D]ebug [R]run [F]ile" })

			vim.keymap.set("n", "<leader>dsc", dap.continue, { desc = "[D]ebug [S]tep [C]ontinue" })
			vim.keymap.set("n", "<leader>dsv", dap.step_over, { desc = "[D]ebug [S]tep O[v]er" })
			vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "[D]ebug [S]tep [I]nto" })
			vim.keymap.set("n", "<leader>dso", dap.step_out, { desc = "[D]ebug [S]tep [O]ut" })

			vim.keymap.set("n", "<leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
			vim.keymap.set("v", "<leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

			vim.keymap.set("n", "<leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
			vim.keymap.set(
				"n",
				"<leader>du",
				":lua localwidgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>"
			)

			vim.keymap.set("n", "<leader>dro", dap.repl.open, { desc = "[D]ebug [R]epl [O]pen" })
			vim.keymap.set("n", "<leader>drx", dap.repl.close, { desc = "[D]ebug [R]epl E[x]it" })

			vim.keymap.set(
				"n",
				"<leader>dbc",
				":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
			)
			vim.keymap.set(
				"n",
				"<leader>db",
				":lua requie('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: '))<CR>"
			)

			vim.keymap.set("n", "<leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
			vim.keymap.set("n", "<leader>di", ui.toggle, { desc = "[D]ebug [I]nterface Toggle" })

			vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "[D]ebug E[x]it" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
