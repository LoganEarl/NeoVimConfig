return {
	"nvim-java/nvim-java",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
	},
	setup = function()
		require("java").setup({
			root_markers = {
				"pom.xml",
				".git",
			},
			java_test = {
				enable = true,
			},
			java_debug_adapter = {
				enable = true,
			},
			spring_boot_tools = {
				enable = true,
			},
			lombok = {
				enable = true,
			},
			jdk = {
				enable = true,
			},
			notifications = {
				dap = true,
			},
			verification = {
				invalid_order = true,
				duplicate_setup_calls = true,
				invalid_mason_registery = true,
			},
		})
	end,
}
