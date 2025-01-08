return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			change_to_vcs_root = true,
			config = {
				header = {
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                             ████████████████████████████████████████████                             ",
					"                             ████████████████████████████████████████████                             ",
					"                             ████████████████████████████████████████████                             ",
					"                             ████████████████████████████████████████████                             ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████                                            ███████                      ",
					"                      ███████       ████████              ████████       ███████                      ",
					"                      ███████       ████████              ████████       ███████                      ",
					"                      ███████       ████████              ████████       ███████                      ",
					"                      ███████       ████████              ████████       ███████                      ",
					"                      ▒▒▒▒▒▒▒                                            ▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒                                            ▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒                                            ▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒                                            ▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░      ████████████████      ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░      ████████████████      ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░      ████████████████      ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░      ████████████████      ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                      ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                      ",
					"                             ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                             ",
					"                             ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                             ",
					"                             ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                             ",
					"                             ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                             ",
					"                                            ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                            ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                            ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                            ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                                   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                                   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                                   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                                   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░                                    ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
					"                                                                                                      ",
				},
				center = {
					{
						icon = " ",
						desc = "Open File [E]xplorer",
						keymap = "<leader> e",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
