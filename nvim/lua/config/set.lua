vim.opt.background                          = 'dark'
vim.opt.termguicolors                       = true
vim.opt.colorcolumn                         = "120"
vim.opt.guicursor                           = ""
vim.opt.syntax                              = 'on'
vim.opt.nu                                  = true
vim.opt.relativenumber                      = true
vim.opt.tabstop                             = 4
vim.opt.softtabstop                         = 4
vim.opt.shiftwidth                          = 4
vim.opt.expandtab                           = true
vim.opt.smartindent                         = true
vim.opt.wrap                                = false
vim.opt.swapfile                            = false
vim.opt.backup                              = false
vim.opt.undodir                             = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile                            = true
vim.opt.incsearch                           = true
vim.opt.scrolloff                           = 16
vim.opt.signcolumn                          = "yes"
vim.opt.updatetime                          = 50
vim.opt.encoding                            = 'UTF-8'
vim.opt.guifont                             = ':JetBrainsMono Nerd Font:h16'
vim.opt.virtualedit                         = 'all'
vim.opt.diffopt                             = { "internal,filler,closeoff,vertical" }
vim.opt.nu                                  = true
vim.opt.ttyfast                             = true
vim.opt.inccommand                          = 'nosplit'
vim.opt.hidden                              = true
vim.opt.showtabline                         = 4
vim.opt.shiftwidth                          = 4
vim.opt.smartcase                           = true
vim.opt.hls                                 = true
vim.opt.ruler                               = false
vim.opt.autoread                            = true
vim.opt.autowrite                           = true
vim.opt.wildmenu                            = true
vim.opt.spelllang                           = 'en_us'
vim.opt.spell                               = true
vim.opt.cursorline                          = true
vim.opt.mouse                               = nil
vim.g.do_filetype_lua                       = 1
vim.g.netrw_browser_split                   = 2
vim.g.netrw_banner                          = 0
vim.g.netrw_keep_term_open                  = 1
vim.g.netrw_winsize                         = 30
vim.g.ft                                    = 'tmux tw=0 nowrap:'
vim.g.fugitive_git_executable               = '/opt/homebrew/bin/hub'
vim.g.completion_matching_strategy_list     = { 'exact', 'substring', 'fuzzy' }
vim.g.svelte_preprocessors                  = { 'typescript' }
vim.g.rust_clip_command                     = 'pbcopy'
vim.g['prettier#quickfix_enabled']          = 0
vim.g['prettier#autoformat_require_pragma'] = 0
vim.g['test#preserve_screen']               = 1
vim.g['test#strategy']                      = 'toggleterm'
vim.api.nvim_set_hl(0, "Visual", { ctermbg = 0, bg = '#6877a5' })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = '#44475a' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderline', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderline', { undercurl = true })
vim.opt.isfname:append("@-@")
