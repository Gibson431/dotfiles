return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		require("catppuccin").setup({
			flavour = "macchiato",
		})
	end,
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
