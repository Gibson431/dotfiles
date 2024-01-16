local plugins = {

    "nvim-lua/plenary.nvim",

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "lua", "pascal", "cpp", "bash" },
                highlight = { enable = true },
            }
        end,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        lazy = true,
    },

    {

        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            -- local actions = require "telescope.actions"
            -- require("telescope").setup {
            --     defaults = {
            --         mappings = {
            --             n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
            --         },
            --     },
            -- }
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "InsertEnter",
        -- config = function()
        --     require("gitsigns").setup()
        -- end,
        opts = {},
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
        },
    },

    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {},
    },
}

return plugins
