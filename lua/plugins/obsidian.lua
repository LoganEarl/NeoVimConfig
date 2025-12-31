local function transfer_todos_from_previous_day()
	local daily_notes_path = vim.fn.expand("~/Documents/ScratchFiles/Daily Notes")
	local today = os.date("%Y-%m-%d")

	local today_file = daily_notes_path .. "/" .. today .. ".md"

	-- Check if today's file exists and has substantial content
	local today_exists = vim.fn.filereadable(today_file) == 1
	if today_exists then
		local today_content = vim.fn.readfile(today_file)
		if #today_content > 2 then -- More than just header
			return
		end
	end

	-- Find most recent previous note
	local files = vim.fn.glob(daily_notes_path .. "/*.md", false, true)
	table.sort(files, function(a, b)
		return a > b
	end)

	local previous_file = nil
	local previous_date = nil
	for _, file in ipairs(files) do
		-- Leverage the fact that the files are named for the date. Remove the preceeding path and extension
		local file_date = vim.fn.fnamemodify(file, ":t:r")
		if file_date < today then
			previous_file = file
			previous_date = file_date
			break
		end
	end

	if not previous_file or vim.fn.filereadable(previous_file) ~= 1 then
		vim.notify("No previous note found for TODO transfer", vim.log.levels.INFO)
		return
	end

	local previous_lines = vim.fn.readfile(previous_file)
	local todos_section = {}
	local in_todos = false
	local in_checked_item = false
	local last_sub_bullet_section = {}

	local function insert_pending_sub_bullets()
		if next(last_sub_bullet_section) ~= nil then
			vim.list_extend(todos_section, last_sub_bullet_section)
			last_sub_bullet_section = {}
		end
	end

	for _, line in ipairs(previous_lines) do
		-- Transfer over our top level header
		if line:match("^# ") then
			table.insert(todos_section, line)
		end
		if line:match("^## TODOs") then
			in_todos = true
			table.insert(todos_section, line)
		elseif in_todos and line:match("^## ") then
			break
		elseif in_todos then
			if line:match("^%- %[ %]") then -- Unchecked item
				insert_pending_sub_bullets()

				in_checked_item = false
				table.insert(todos_section, line)
			elseif line:match("^%- %[X%]") or line:match("^%- %[x%]") then -- Skip checked items
				insert_pending_sub_bullets()

				in_checked_item = true
			else
				-- Reset in_checked_item for subsection headers
				if line:match("^###") or line:match("^%S*$") then
					insert_pending_sub_bullets()
					in_checked_item = false
				end

				if not in_checked_item then
					if line:match("^%s%s%- ") then -- singulary nested sub bullet (nested only once)
						last_sub_bullet_section = { line }
					elseif line:match("^%s%s%s+%- ") then -- nested more than one time
						table.insert(last_sub_bullet_section, line)
					else
						if next(last_sub_bullet_section) ~= nil then
							vim.list_extend(todos_section, last_sub_bullet_section)
							last_sub_bullet_section = {}
						end
						table.insert(todos_section, line)
					end
				end
			end
		end
	end

	-- Add final sub-bullet if exists
	if next(last_sub_bullet_section) ~= nil then
		vim.list_extend(todos_section, last_sub_bullet_section)
	end

	-- Write to today's file
	if #todos_section > 0 then
		vim.fn.writefile(todos_section, today_file)
		local todo_count = 0
		for _, line in ipairs(todos_section) do
			if line:match("^%- %[ %]") then
				todo_count = todo_count + 1
			end
		end
		vim.notify(string.format("Transferred %d TODO items from %s", todo_count, previous_date), vim.log.levels.INFO)
	else
		vim.notify("No TODOs found to transfer", vim.log.levels.INFO)
	end
end

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = false,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/ScratchFiles",
				},
			},
			daily_notes = {
				folder = "Daily Notes",
			},
			disable_frontmatter = true,
			ui = {
				enable = false,
			},
			note_id_func = function(title)
				if title ~= nil then
					return title
				else
					return tostring(os.time())
				end
			end,
		})

		-- Auto-transfer TODOs when opening today's note
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*/Daily Notes/*.md",
			callback = function()
				local filename = vim.fn.expand("%:t:r")
				local today = os.date("%Y-%m-%d")
				if filename == today then
					transfer_todos_from_previous_day()
					vim.cmd("edit!") -- Reload the file
				end
			end,
		})
	end,
}
