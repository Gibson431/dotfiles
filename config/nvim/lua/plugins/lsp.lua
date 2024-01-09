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
			require("mason-lspconfig").setup({ensure_installed = {"lua_ls"}})
			require("mason-lspconfig").setup_handlers {
				function(server_name) 
					require("lspconfig")[server_name].setup{}
				end,
			}
			-- require("nvim-lspconfig").setup()
		end,
	},
}
