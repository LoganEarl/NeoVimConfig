return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			close_if_last_window = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			window = {
				position = "bottom",
				height = 50,
			},
		},
	},
}
