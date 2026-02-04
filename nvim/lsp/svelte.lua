return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_markers = { ".git", "svelte.config.ts", "svelte.config.ts", ".svelte-kit" },
	settings = {
		svelte = {
			plugin = {
				html = {
					completions = { enable = true, emmet = false },
					tag_complete = { enable = true },
				},
				svelte = {
					completions = { enable = true, emmet = false },
					default_script_language = 'typescript',
				},
				css = {
					completions = { enable = true, emmet = false },
				},
			},
		},
	},
}
