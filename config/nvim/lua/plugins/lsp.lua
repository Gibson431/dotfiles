return {
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = "buffer" },
                }),
            }
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = "BufEnter",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup { ensure_installed = { "lua_ls", "bashls" } }
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
            local vim = vim
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    -- local opts = { buffer = ev.buf }
                    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                end,
            })
        end,
    },

    {
        "mhartington/formatter.nvim",
        lazy = true,
        event = "BufEnter",
        config = function()
            local formatter = require "formatter"
            local util = require "formatter.util"
            formatter.setup {
                -- Enable or disable logging
                logging = true,
                -- Set the log level
                log_level = vim.log.levels.WARN,
                -- All formatter configurations are opt-in
                filetype = {
                    lua = {
                        -- "formatter.filetypes.lua" defines default configurations for the
                        -- "lua" filetype
                        require("formatter.filetypes.lua").stylua,

                        -- You can also define your own configuration
                        -- function()
                        -- 	-- Supports conditional formatting
                        -- 	if util.get_current_buffer_file_name() == "special.lua" then
                        -- 		return nil
                        -- 	end
                        --
                        -- 	-- Full specification of configurations is down below and in Vim help
                        -- 	-- files
                        -- 	return {
                        -- 		exe = "stylua",
                        -- 		args = {
                        -- 			"--search-parent-directories",
                        -- 			"--stdin-filepath",
                        -- 			util.escape_path(util.get_current_buffer_file_path()),
                        -- 			"--",
                        -- 			"-",
                        -- 		},
                        -- 		stdin = true,
                        -- 	}
                        -- end,
                    },

                    pascal = {
                        function()
                            return {
                                -- ptop infile outfile
                                exe = "ptop",
                                args = {
                                    util.escape_path(util.get_current_buffer_file_path()),
                                    util.escape_path(util.get_current_buffer_file_path()),
                                },
                                stdin = false,
                            }
                        end,
                    },
                },
            }
        end,
    },

    {
        "mfussenegger/nvim-lint",
        lazy = true,
        event = "BufEnter",
        config = function()
            local lint = require "lint"
            lint.linters_by_ft = { lua = { "luacheck" }, cpp = { "cpplint" } }
        end,
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        event = "BufEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            use_diagnostic_signs = true,
        },
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = { "o" }, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
            close_folds = { "zM", "zm" }, -- close all folds
            open_folds = { "zR", "zr" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- previous item
            next = "j", -- next item
            help = "?", -- help menu
        },
    },
}
