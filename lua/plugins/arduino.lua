if vim.fn.executable("arduino-cli") == 0 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "arduino",
		callback = function()
			vim.notify("Arduino tools not installed. Install arduino-cli to enable Arduino support.", vim.log.levels.WARN)
		end,
	})
	return {}
end

return {
	"stevearc/vim-arduino",
	ft = "arduino",
}
