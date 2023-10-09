return {
    "folke/zen-mode.nvim",
    config = function()
        local zen = require('zen-mode');
        zen.setup({
            window = {
                backdrop = 0.95,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "no",
                    number = false,
                    relativenumber = false,
                    cursorline = false,
                    cursorcolumn = false,
                    foldcolumn = "0",
                    list = false,
                },
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    showcmd = false,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = false },
                tmux = { enabled = false },
            },
            on_open = function(_)
                -- do nothing with win
            end,
            on_close = function()
                -- do nothing
            end,
        })

        vim.keymap.set('n', "<leader>Z", function() zen.toggle({ window = { width = 1 } }) end)
    end
}
