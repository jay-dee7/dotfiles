require('config/auto-format')
local nvim_lsp = require('lspconfig')
local typescript = require("typescript")
local lsp_helpers = require('config/lsp_helpers')

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
cap.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(cap)

nvim_lsp.gopls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            codelenses = {
                gc_details = true,
                tidy = true,
                generate = true,
                upgrade_dependency = true,
                vendor = false
            },
            linkTarget = "pkg.go.dev",
            usePlaceholders = true,
            hoverKind = "FullDocumentation",
            diagnosticsDelay = "200ms",
            analyses = {
                unusedparams = true,
                fieldalignment = true,
                nilness = true,
                shadow = true,
                unusedwrite = true
            },
            staticcheck = true,
            annotations = {
                bounds = true,
                escape = true,
                inline = true,
            },
        }
    }
}

-- nvim_lsp.rust_analyzer.setup({
--     on_attach = lsp_helpers.on_attach,
--     capabilities = capabilities,
--     cmd = {
--         "rust-analyzer"
--     },
--     settings = {
--         ["rust-analyzer"] = {
--
--         }
--     }
-- })

require("rust-tools").setup({
    tools = {
        snippet_func = function(edits, bufnr, offset_encoding, old_func)
            old_func(edits, bufnr, offset_encoding);
        end,
        executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
        reload_workspace_from_cargo_toml = true,
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
        hover_actions = {
            border = "rounded",
        },
    },
    server = {
        standalone = true,
        on_attach = function(client, bufnr)
            lsp_helpers.on_attach(client, bufnr)
            local rt = require("rust-tools")
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                lens = {
                    enable = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
                check = {
                    enable = true,
                    command = "clippy",
                },
            },
        },
    },
})

nvim_lsp.jsonls.setup {
    on_attach = lsp_helpers.on_attach,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
        }
    }
}

nvim_lsp.terraformls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities
}

nvim_lsp.cssls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities
}

typescript.setup({
    disable_commands = false,
    debug = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = {
        on_attach = lsp_helpers.on_attach,
        capabilities = capabilities,
    }
})

nvim_lsp.tailwindcss.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities
}

nvim_lsp.svelte.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
    settings = {
        svelte = {
            plugin = {
                html   = {
                    completions = { enable = true, emmet = false },
                    tag_complete = { enable = true }
                },
                svelte = {
                    completions = { enable = true, emmet = false },
                    default_script_language = "typescript",
                },
                css    = {
                    completions = { enable = true, emmet = false }
                },
            },
        }
    }
}

nvim_lsp.vuels.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities
}

nvim_lsp.graphql.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.eslint.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.lua_ls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    -- vim
                    "vim",
                    "hs",

                    -- Busted
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                    "teardown",
                    "pending",
                    "clear",

                    -- Colorbuddy
                    "Color",
                    "c",
                    "Group",
                    "g",
                    "s",

                    -- Custom
                    "RELOAD",
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                    string.format('%s/.hammerspoon/Spoons/EmmyLua.spoon/annotations', os.getenv 'HOME'),
                }
            },
        },
    },
}

nvim_lsp.yamlls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            keyOrdering = false
        }
    }
}
nvim_lsp.bufls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.prismals.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.sqlls.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.pyright.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.taplo.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}

nvim_lsp.clangd.setup {
    on_attach = lsp_helpers.on_attach,
    capabilities = capabilities,
}
