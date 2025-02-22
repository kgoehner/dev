return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		numhl = true,

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
			vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })
			vim.keymap.set("n", "<leader>gh", gs.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })
			vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame Line" })
			vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff This" })
			vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
			vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
			vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Stage Hunk" })
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { buffer = bufnr, desc = "Reset Hunk" })
		end,
	},
}
