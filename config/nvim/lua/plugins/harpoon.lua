return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		vim.api.nvim_create_user_command(
			"Harpoon",
			"lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())",
			{
				bang = true,
				desc = "Open the harpoon list",
			}
		)
	end,
	config = function()
		local harpoon = require "harpoon"
		harpoon:setup()
		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table {
						results = file_paths,
					},
					previewer = conf.file_previewer {},
					sorter = conf.generic_sorter {},
				})
				:find()
		end

		vim.keymap.set("n", "<leader>e", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })
	end,
}
