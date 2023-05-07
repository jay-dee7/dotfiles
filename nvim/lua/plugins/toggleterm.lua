return {
    'akinsho/toggleterm.nvim',
    config = function()
        local ok, toggleterm = pcall(require, "toggleterm")
        if not ok then
            return
        end

        toggleterm.setup({
            size = 25,
            open_mapping = [[<C-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            highlights = {
                border = 'Normal',
                background = 'Normal',
            },
            float_opts = {
                border = 'curved',
                winblend = 5,
                width = function()
                    return math.floor(vim.o.columns * 0.90)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.35)
                end
            },
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return term.name
                end
            }
        })

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-l>', [[<C-l>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
}
