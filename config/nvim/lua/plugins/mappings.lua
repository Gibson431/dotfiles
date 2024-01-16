local vim = vim

local normal_mappings = {
    K = { vim.lsp.buf.hover, "Hover" },
    ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
    ["<leader>"] = {
        ["h"] = { "<cmd>Harpoon<cr>", "Open Harpoon quick menu" },
        ["/"] = { require("Comment.api").toggle.linewise.current, "Comment linewise" },
        -- ["h"] = { "<cmd>Harpoon toggle_quick_menu<cr>", "Open Harpoon quick menu" },
        s = {
            name = "Search",
            r = { "<cmd>Telescope registers<cr>", "Registers" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },
        },
        g = {
            name = "Git",
            g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = {
                "<cmd>Gitsigns diffthis HEAD<cr>",
                "Diff",
            },
        },
        f = {
            name = "Files",
            h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
            M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
            f = { "<cmd>Telescope find_files<cr>", "Find Files" },
            g = { "<cmd>Telescope git_files<cr>", "Git Files" },
        },
        ["?"] = {
            name = "Config",
            c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        },
        l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Code Action" },
            d = { vim.lsp.buf.definition, "Goto Definition" },
            D = { vim.lsp.buf.declaration, "Goto Declaration" },
            r = { vim.lsp.buf.rename, "Rename" },
            t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
        },
    },
}

local visual_mappings = {
    ["<leader>"] = {
        ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment" },
    },
}

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 200
    end,
    config = function()
        require("which-key").register(normal_mappings, { mode = "n" })
        require("which-key").register(visual_mappings, { mode = "v" })
    end,
}
