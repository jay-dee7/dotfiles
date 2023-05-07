return {
	'theprimeagen/harpoon',
    config = function ()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        require("harpoon").setup({
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
            },
        })

        vim.keymap.set("n", "<leader>ma", mark.add_file)
        vim.keymap.set("n", "<leader>mr", mark.rm_file)
        vim.keymap.set("n", "<leader>mra", mark.clear_all)
        vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end)
        vim.keymap.set("n", "<leader>ms", ui.toggle_quick_menu)
    end
}
