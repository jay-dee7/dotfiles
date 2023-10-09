function go_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end

    vim.lsp.buf.format()
end

vim.cmd [[ autocmd BufWritePre *.tf lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.rs lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.go lua go_imports(2000)]]
vim.cmd [[ autocmd BufWritePre *.lua lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.toml lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.ts lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.js lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.svelte lua vim.lsp.buf.format() ]]
vim.cmd [[ autocmd BufWritePre *.lua lua vim.lsp.buf.format() ]]
