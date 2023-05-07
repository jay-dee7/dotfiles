return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function ()
        require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                operators = true,
                comments = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {
                dark0_hard = "#0f1011"
            },
            overrides = {
                SignColumn = {bg = "#1d2021"},
                ["@text.note"] = {bold = true, reverse = false, fg = "", bg = "#213352"},
                ["@constant.builtin"] = { link = "GruvboxPurple"},
            },
            dim_inactive = false,
            transparent_mode = false,
        })
        vim.cmd('colorscheme gruvbox')
    end
}
