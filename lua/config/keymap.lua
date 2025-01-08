vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.relativenumber = true
vim.opt.showmode = true
vim.opt.scrolloff = 20

-- Keep undo history
vim.opt.undofile = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

vim.opt.splitright = false
vim.opt.splitbelow = true

-- Tabs setup
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.conceallevel = 2

-- Arduino Keymaps
vim.keymap.set("n", "<leader>aa", "<cmd>ArduinoAttach<CR>", { desc = "[A]rduino [A]ttach to a board" })
vim.keymap.set("n", "<leader>av", "<cmd>ArduinoVerify<CR>", { desc = "[A]rduino [V]erify sources" })
vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<CR>", { desc = "[A]rduino [U]pload sources" })
vim.keymap.set(
	"n",
	"<leader>aa",
	"<cmd>ArduinoUploadAndSerial<CR>",
	{ desc = "[A]rduino Upload sources [A]nd start Serial" }
)
vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<CR>", { desc = "[A]rduino start [S]erial" })
vim.keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", { desc = "[A]rduino [C]hoose [B]oard" })
vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", { desc = "[A]rduino [C]hoose [P]rogrammer" })

-- Obsidian Keymaps
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "[O]bsidian open [T]oday's note" })
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "[O]bsidian open [Y]esterday's note" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "[O]bsidian open a [N]ew note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianQuickSwitch<CR>", { desc = "[O]bsidian [S]earch for a note" })
vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "[O]bsidian [R]ename current note" })

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>tt", "<cmd>FloatermShow<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>FloatermToggle<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>e", ":Oil --float<CR>", { desc = "Open File [E]xplorer" })

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
