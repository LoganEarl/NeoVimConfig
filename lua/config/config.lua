vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use fancy symbols. Allows you to have icons for java files, js files, and other niceties.
vim.g.have_nerd_font = true

-- Personal preference
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showmode = true
vim.opt.scrolloff = 20

-- Keep undo history
vim.opt.undofile = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.splitright = false
vim.opt.splitbelow = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Tabs to spaces setup
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.linebreak = true
vim.o.wrap = true
vim.o.breakindent = true

-- Let plugins change the way characters appear. Nice for markdown and the Obsidian vault editor
vim.o.conceallevel = 2

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.opt.spelloptions = "camel"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.md",
	command = "setlocal spell spelllang=en_us",
})
