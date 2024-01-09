return {

	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/cmp-buffer",

	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- ...
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
			require("mason-lspconfig").setup { ensure_installed = { "lua_ls" } }
			require("mason-lspconfig").setup_handlers {
				function(server_name)
					require("lspconfig")[server_name].setup {}
				end,
			}
			-- require("nvim-lspconfig").setup()
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require "null-ls"
			null_ls.setup {
				sources = null_ls.builtins.formatting.stylua,
				on_attach = function(client, bufnr)
					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
					if client.supports_method "textDocument/formatting" then
						vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
								-- vim.lsp.buf.formatting_sync()
								vim.lsp.buf.format { async = false }
							end,
						})
					end
				end,
				-- on_attach = setup_autosave,
			}
		end,
	},
}
