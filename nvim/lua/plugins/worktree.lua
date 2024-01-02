return {
	'polarmutex/git-worktree.nvim',
	config = function()
		local worktree = require("git-worktree")
		local telescope_worktree = require("telescope").extensions.git_worktree

		worktree.on_tree_change(function(op, metadata)
			if op == worktree.Operations.Switch then
				print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
			end
		end)

		worktree.setup({
			change_directory_command = 'cd',
			update_on_change = true,
			update_on_change_command = 'e .',
			clearjumps_on_change = true,
			autopush = false,
		})

		vim.keymap.set('n', "<leader>wm", telescope_worktree.git_worktree, { silent = true })
		vim.keymap.set('n', "<leader>wl", telescope_worktree.git_worktrees, { silent = true })
		vim.keymap.set('n', "<leader>wn", telescope_worktree.create_git_worktree, { silent = true })
	end
}
