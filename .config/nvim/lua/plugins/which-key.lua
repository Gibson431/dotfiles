return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    dependencies = {
      { 'echasnovski/mini.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 100,
    },
    keys = {
      -- Find
      { '<leader>s', group = '[S]earch' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = '[s]earch [f]iles', mode = 'n' },
      { '<leader>sF', '<cmd>Telescope git_files<cr>', desc = '[s]earch git [F]iles', mode = 'n' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[s]earch [G]rep', mode = 'n' },
      { '<leader>sr', require('telescope.builtin').lsp_references, desc = '[s]earch [r]eferences', mode = 'n' },
      { '<leader>sd', require('telescope.builtin').lsp_definitions, desc = '[s]earch [d]efinitions', mode = 'n' },
      { '<leader>sr', '<cmd>Telescope lsp_references<cr>', desc = 'References', mode = 'n' },

      -- LSP
      { '<leader>lr', vim.lsp.buf.rename, desc = '[L]sp [R]ename', mode = 'n' },
      { '<leader>lf', vim.lsp.buf.format, desc = '[L]sp [F]ormat', mode = 'n' },
      { '<leader>la', vim.lsp.buf.code_action, desc = '[L]sp [A]ction', mode = 'n' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Declaration', mode = 'n' },
      { 'gd', vim.lsp.buf.definition, desc = 'Definition', mode = 'n' },
    },
  },
}
