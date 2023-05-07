return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {
            'windwp/nvim-autopairs',
            event = 'InsertCharPre',
            config = function()
                require("nvim-autopairs").setup()
                -- Integration w/ nvim-cmp
                require('cmp').event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
            end,
        },

        'L3MON4D3/LuaSnip',             -- Required
        'rafamadriz/friendly-snippets', -- Optional
        'hrsh7th/cmp-nvim-lsp',         -- Required
        'hrsh7th/cmp-buffer',           -- Optional
        'hrsh7th/cmp-path',             -- Optional
        'saadparwaiz1/cmp_luasnip',     -- Optional
        'hrsh7th/cmp-nvim-lua',         -- Optional
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {
            "roobert/tailwindcss-colorizer-cmp.nvim",
            -- optionally, override the default options:
            config = function()
                require("tailwindcss-colorizer-cmp").setup({
                    color_square_width = 2,
                })
            end
        },
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        require("luasnip.loaders.from_vscode").lazy_load()

        local kind_icons = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = ""
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-y>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Select,
                    select = false,
                },
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = "path" },
                { name = 'buffer' },
                { name = 'nvim_lsp_signature_help' },
            }),
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = 'λ',
                    luasnip = '⋗',
                    buffer = 'Ω',
                    path = '🖫',
                    nvim_lua = 'Π',
                }

                item.menu = menu_icon[entry.source.name]
                return item
            end,
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = {
                    max_height = 35,
                    max_width = 120,
                    border = 'rounded',
                    col_offset = 0,
                    side_padding = 1,
                    winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
                    zindex = 1001,
                },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    if vim_item.kind == "Color" then
                        local tailwind_colors = require("tailwindcss-colorizer-cmp")
                        tailwind_colors.formatter(entry, vim_item)
                    end
                    -- Kind icons
                    -- This concatonates the icons with the name of the item kind
                    vim_item.menu = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                    -- Source
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]",
                    })[entry.source.name]
                    return vim_item
                end
            },
        })
    end
}
