return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		'astro',
		'astro-markdown',
		'ejs',
		'gohtml',
		'gohtmltmpl',
		'handlebars',
		'hbs',
		'html',
		'markdown',
		'mdx',
		'mustache',
		'twig',
		'css',
		'less',
		'postcss',
		'sass',
		'scss',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'vue',
		'svelte',
	},
	root_markers = {
		'tailwind.config.js',
		'tailwind.config.cjs',
		'tailwind.config.mjs',
		'tailwind.config.ts',
		'postcss.config.js',
		'postcss.config.cjs',
		'postcss.config.mjs',
		'postcss.config.ts',
		'app.css',
		'app.postcss',
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = 'warning',
				invalidApply = 'error',
				invalidScreen = 'error',
				invalidVariant = 'error',
				invalidConfigPath = 'error',
				invalidTailwindDirective = 'error',
				recommendedVariantOrder = 'warning',
			},
			classAttributes = {
				'class',
				'className',
				'class:list',
				'classList',
				'ngClass',
			},
			includeLanguages = {
				eelixir = 'html-eex',
				elixir = 'phoenix-heex',
				eruby = 'erb',
				heex = 'phoenix-heex',
				htmlangular = 'html',
				templ = 'html',
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			config.settings = {}
		end
		if not config.settings.editor then
			config.settings.editor = {}
		end
		if not config.settings.editor.tabSize then
			config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
		end
	end,
	workspace_required = true,
}
