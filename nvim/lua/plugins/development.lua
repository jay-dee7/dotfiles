return {
    'folke/neodev.nvim',
    'jbyuki/venn.nvim',
    'nvim-lua/lsp-status.nvim',
    'jvirtanen/vim-hcl',
    'windwp/nvim-ts-autotag',
    'prisma/vim-prisma',
    'cespare/vim-toml',
    'ThePrimeagen/vim-be-good',
    -- Lazy Loaded plugins
    -- use { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim'}
    { 'jremmen/vim-ripgrep',         lazy = true, cmd = { 'Rg' } },
    { 'norcalli/nvim-colorizer.lua', lazy = true, cmd = { 'ColorizerToggle' } },
    {
        'prettier/vim-prettier',
        build = "yarn install --frozen-lockfile --production",
        lazy = true,
        cmd = { 'Prettier', 'PrettierAsync' },
    },
    config = function()
        require("neodev").setup({
            library = { plugins = { "nvim-dap-ui", "nvim-dap" }, types = true }
        })
    end
}
