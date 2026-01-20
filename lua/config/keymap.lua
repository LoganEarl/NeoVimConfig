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
vim.keymap.set("n", "<leader>og", "<cmd>ObsidianSearch<CR>", { desc = "[O]bsidian [G]rep using note contents" })
vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "[O]bsidian [R]ename current note" })

vim.keymap.set("n", "<leader>jp", function()
	print(require("jsonpath").get())
end, { desc = "Print JSON path under cursor" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle bottom<CR>", { desc = "Open File [E]xplorer" })
vim.keymap.set("n", "<leader>d", ":w<CR>:bd<CR>", { desc = "Save and [D]elete the current buffer" })
vim.keymap.set("n", "<leader>q", ":bd!<CR>", { desc = "[Q]uit the current buffer without saving" })

-- This makes it so you can navigate through soft wrapped lines with j and k like usual.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "$", "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
vim.keymap.set("n", "_", "v:count == 0 ? 'g_' : '_'", { expr = true, silent = true })
vim.keymap.set("n", "^", "v:count == 0 ? 'g^' : '^'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "[T]oggle [T]erminal" })

-- Global variable to keep track of the terminal buffer number and window ID
-- This is optional but helps with managing state in a single session
if vim.g.term_v_buf_id == nil then
	vim.g.term_v_buf_id = nil
end

if vim.g.term_v_win_id == nil then
	vim.g.term_v_win_id = nil
end
