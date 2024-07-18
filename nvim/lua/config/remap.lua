vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('i', '<C-c>', '<ESC>')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprevious<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')
vim.keymap.set('x', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>h', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<leader>j', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<leader>k', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<leader>l', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<leader>C', '<cmd>ColorToggle<CR>')
vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>')
vim.keymap.set('n', '<leader>pv', '<cmd>wincmd v<bar> :Lex <bar> :vertical resize 30<CR>')
vim.keymap.set('n', '<leader><Space>', '<C-^>')
vim.keymap.set('n', '<leader><silent> <Leader>+', '<cmd>vertical resize +5<CR>')
vim.keymap.set('n', '<leader><silent> <Leader>-', '<cmd>vertical resize -5<CR>')
vim.keymap.set('n', '<leader>re', '<cmd>:source ~/.config/nvim/init.lua<CR>', { remap = false, silent = true })
vim.keymap.set('n', '<leader>TT', '<cmd>Ttoggle<CR>', { remap = false })

vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>')

vim.keymap.set('n', '<leader>S', function()
	vim.lsp.stop_client(vim.lsp.get_clients())
end)

-- nmap<leader>gj :diffget //3<CR>
-- nmap<leader>gf :diffget //2<CR>
