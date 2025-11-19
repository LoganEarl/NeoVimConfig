return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nickkadutskyi/jb.nvim",
		lazy = false,
		priority = 999,
		config = function()
			-- Set default theme
			vim.cmd([[colorscheme tokyonight]])

			-- Define code filetypes
			local code_filetypes = {
				"javascript",
				"typescript",
				"python",
				"lua",
				"c",
				"cpp",
				"rust",
				"go",
				"php",
				"ruby",
				"swift",
				"kotlin",
				"scala",
				"html",
				"css",
				"scss",
				"json",
				"xml",
				"yaml",
				"toml",
				"sh",
				"bash",
				"zsh",
				"vim",
				"sql",
			}

			-- Track current theme state
			local current_theme = "tokyonight"

			-- Helper function to check if filetype is code
			local function is_code_filetype(ft)
				for _, code_ft in ipairs(code_filetypes) do
					if ft == code_ft then
						return true
					end
				end
				return false
			end

			-- Helper function to check if buffer should be ignored
			local function should_ignore_buffer()
				local buftype = vim.bo.buftype
				local filetype = vim.bo.filetype

				-- Ignore floating windows, popups, and temporary buffers
				if buftype ~= "" and buftype ~= "acwrite" then
					return true
				end
				if filetype == "TelescopePrompt" or filetype == "TelescopeResults" then
					return true
				end
				if vim.api.nvim_win_get_config(0).relative ~= "" then
					return true
				end

				return false
			end

			-- Create autocmd for theme switching
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if should_ignore_buffer() then
						return
					end

					local ft = vim.bo.filetype
					local target_theme = is_code_filetype(ft) and "jb" or "tokyonight"

					if target_theme ~= current_theme then
						current_theme = target_theme
						vim.cmd([[colorscheme ]] .. target_theme)
					end
				end,
			})
		end,
	},
}
