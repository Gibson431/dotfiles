return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    dependencies = {
      { 'echasnovski/mini.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 0,
    },
    keys = {
      -- Find
      { '<leader>f', group = '[F]ind' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[F]ind [F]iles', mode = 'n' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[F]ind [G]rep', mode = 'n' },
      { '<leader>fr', require('telescope.builtin').lsp_references, desc = '[F]ind [R]eferences', mode = 'n' },
      { '<leader>fd', require('telescope.builtin').lsp_definitions, desc = '[F]ind [D]efinitions', mode = 'n' },

      -- LSP
      { '<leader>lr', vim.lsp.buf.rename, desc = '[L]sp [R]ename', mode = 'n' },
      { '<leader>lf', vim.lsp.buf.format, desc = '[L]sp [F]ormat', mode = 'n' },
      { '<leader>la', vim.lsp.buf.code_action, desc = '[L]sp [A]ction', mode = 'n' },
    },
  },
}
