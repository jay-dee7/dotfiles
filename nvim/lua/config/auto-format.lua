vim.cmd [[ autocmd BufWritePre *.tf lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.lua lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.svelte lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.rs lua vim.lsp.buf.format() ]]
vim.cmd("autocmd BufWritePre *.ts :PrettierAsync")
vim.cmd("autocmd BufWritePre *.js :PrettierAsync")
vim.cmd("autocmd BufWritePre *.svelte :PrettierAsync")
