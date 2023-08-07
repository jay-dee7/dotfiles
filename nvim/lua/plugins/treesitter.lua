return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'go',
                'gomod',
                'gosum',
                'llvm',
                'json',
                'lua',
                'markdown',
                'proto',
                'rust',
                'svelte',
                'toml',
                'tsx',
                'typescript',
                'yaml',
                'dockerfile',
                'graphql',
                'comment',
                'css',
                'scss',
                'sql',
                'http',
                'c',
                'cpp',
                'capnp',
                'cmake',
                'diff',
                'hurl',
            },
            auto_pairs = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<C-s>",
                    node_decremental = "<C-backspace>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                }
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            refactor = {
                highlight_definitions = false,
                highlight_current_scope = { enable = false },
                smart_rename = {
                    enable = true,
                    -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                    keymaps = {
                        smart_rename = "trr",
                    },
                },
            }
        }

        require('treesitter-context').setup({})
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx", 'ts' }
        parser_config.hcl.filetype_to_parsername = { "hcl", "tf" }
    end
}
