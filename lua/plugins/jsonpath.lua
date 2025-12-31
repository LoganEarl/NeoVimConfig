return {
	"phelipetls/jsonpath.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Required dependency
	ft = { "json", "jsonc" }, -- Only load for JSON files
	config = function()
		require("jsonpath").setup()
	end,
}
