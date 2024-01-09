return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		vim.api.nvim_create_user_command(
		'Harpoon',
	"lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())",
	{
		bang = true, 
		desc = "Open the harpoon list"
	}
		)
	end,
	config = function()
		require("harpoon"):setup()
	end,
}
