return {
    "windwp/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "Spectre" },
    keys = {
        { "<leader>crs", "<cmd>Spectre<cr>", desc = "search and replace" },
    },
    config = true,
}
