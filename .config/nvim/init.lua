vim.g.mapleader = ' '

-- opts
vim.opt.number = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.shiftwidth = 0
vim.opt.signcolumn = 'yes'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 0
vim.opt.cursorline = true
vim.opt.winborder = 'rounded'
vim.opt.scrolloff = 7

-- packages
vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' },
}

vim.cmd.colorscheme 'catppuccin-frappe'

require('mini.basics').setup()
require('mini.extra').setup()
require('mini.completion').setup()
require('mini.pick').setup()
require('mini.cursorword').setup()
require('mini.pairs').setup()
require('mini.icons').setup()
require('mini.indentscope').setup { options = { try_as_border = true } }
require('mason').setup()
require('ibl').setup()
require('lualine').setup()
require('tiny-inline-diagnostic').setup { preset = 'simple', show_all_diags_on_cursorline = true }
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}
require('conform').setup {
  notify_on_error = false,
  formatters_by_ft = {
    lua = { 'stylua' },
    cpp = { 'clang-format' },
    rust = { 'rust_analyzer' },
  },
}

-- lsp
vim.lsp.enable { 'lua_ls', 'shellcheck', 'clangd', 'rust_analyzer' }

-- keymaps
require('which-key').add {
  { '<leader>e', '<cmd>Explore<cr>', desc = 'Oil' },
  {
    group = 'Lsp',
    { '<leader>l', group = 'Lsp' },
    { '<leader>lf', '<cmd>Format<cr>', desc = 'Lsp Format' },
    { '<leader>lr', vim.lsp.buf.rename, desc = 'Lsp Rename' },
    { '<leader>la', vim.lsp.buf.code_action, desc = 'Lsp Action' },
  },
  {
    group = 'Search',
    { '<leader>s', group = 'Search' },
    { '<leader>sf', '<cmd>Pick files<cr>', desc = 'Search Files' },
    { '<leader>sb', '<cmd>Pick buffers<cr>', desc = 'Search Buffers' },
  },
  { '<esc><esc>', '<cmd>nohlsearch<cr>', silent = true },
  { 'gD', vim.lsp.buf.declaration, desc = 'Declaration' },
  { 'gd', vim.lsp.buf.definition, desc = 'Definition' },
}

-- cmds
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })
