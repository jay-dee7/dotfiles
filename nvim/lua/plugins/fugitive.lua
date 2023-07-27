return {
  'tpope/vim-fugitive',
  lazy = true,
  cmd = { 'G' },
  keys = {
    -- VIM Fugitive - Git
    { '<leader>gs',  '<cmd>G<CR>' },
    { '<leader>gj',  ':diffget //3<CR>' },
    { '<leader>gf',  ':diffget //2<CR>' },
    { '<leader>gl',  '<cmd>G pull origin main<CR>' },
    { '<leader>gp',  '<cmd>G push-current<CR>' },
    { '<leader>gpf', '<cmd>G push-current -f<CR>' },
    { '<leader>gr',  ':G rebase ' },
    { '<leader>ra',  ':G rebase --abort' },
    { '<leader>rc',  ':G rebase --continue<CR>' },
    { '<leader>gfa', ':G fixup -S<CR>' },
    { '<leader>gC',  ':G commit -S<CR>' },
  }
}
