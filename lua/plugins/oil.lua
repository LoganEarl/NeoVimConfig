return {
	"stevearc/oil.nvim",

	config = function()
		require("oil").setup({
			skip_confirm_for_simple_edits = false,
			default_file_explorer = true,
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			delete_to_trash = true,
			float = {
				padding = 4,
			},
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<leader>e"] = "actions.close",
			},
		})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
