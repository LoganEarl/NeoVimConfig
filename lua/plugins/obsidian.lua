local function load_recurring_tasks()
	local config_path = vim.fn.expand("~/Documents/ScratchFiles/Daily Notes/recurring-tasks.json")
	if vim.fn.filereadable(config_path) ~= 1 then
		return {}
	end
	local content = table.concat(vim.fn.readfile(config_path), "\n")
	return vim.fn.json_decode(content)
end

local function should_add_recurring_task(task, date_str)
	local year, month, day = date_str:match("(%d+)-(%d+)-(%d+)")
	local time = os.time({ year = year, month = month, day = day })
	local date_info = os.date("*t", time)

	if task.recurrence.type == "day_of_week" then
		local day_of_week = (date_info.wday == 1) and 7 or (date_info.wday - 1)
		return day_of_week == task.recurrence.value
	elseif task.recurrence.type == "day_of_month" then
		return date_info.day == task.recurrence.value
	end
	return false
end

local function task_exists_in_section(task_text, todos_section)
	for _, line in ipairs(todos_section) do
		local text = line:match("^%- %[[ Xx]%] (.+)$")
		if text == task_text then
			return true
		end
	end
	return false
end

local function insert_recurring_tasks(todos_section, today, previous_date)
	local tasks = load_recurring_tasks()
	local recurring_tasks = {}
	local added_tasks = {}

	local function parse_date(date_str)
		local year, month, day = date_str:match("(%d+)-(%d+)-(%d+)")
		return os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day), hour = 12 })
	end

	local start_time = previous_date and parse_date(previous_date) or parse_date(today)
	local end_time = parse_date(today)

	-- Iterate through each day from previous_date to today
	local current_time = start_time + 86400 -- Start from day after previous_date
	while current_time <= end_time do
		local date_str = os.date("%Y-%m-%d", current_time)

		for _, task in ipairs(tasks) do
			if
				should_add_recurring_task(task, date_str)
				and not task_exists_in_section(task.text, todos_section)
				and not added_tasks[task.text]
			then
				table.insert(recurring_tasks, "- [ ] " .. task.text)
				added_tasks[task.text] = true
			end
		end

		current_time = current_time + 86400
	end

	local alreadyHasRecurringSection = false
	if #recurring_tasks > 0 then
		local insert_pos = 1
		for i, line in ipairs(todos_section) do
			if line:match("^## TODOs") then
				insert_pos = i + 1
			elseif line:match("### Recurring") then
				alreadyHasRecurringSection = true
				insert_pos = i + 1
			end
		end

		if not alreadyHasRecurringSection then
			table.insert(todos_section, insert_pos, "### Recurring")
		end
		for i, task in ipairs(recurring_tasks) do
			table.insert(todos_section, insert_pos + i, task)
		end
		table.insert(todos_section, insert_pos + #recurring_tasks + 1, "")
	end
end

local function generate_daily_note_content(skip_content_check)
	local daily_notes_path = vim.fn.expand("~/Documents/ScratchFiles/Daily Notes")
	local today = os.date("%Y-%m-%d")
	local today_file = daily_notes_path .. "/" .. today .. ".md"

	if not skip_content_check then
		local today_exists = vim.fn.filereadable(today_file) == 1
		if today_exists then
			local today_content = vim.fn.readfile(today_file)
			if #today_content > 2 then
				return nil, "Today's note already has substantial content"
			end
		end
	end

	local files = vim.fn.glob(daily_notes_path .. "/*.md", false, true)
	table.sort(files, function(a, b)
		return a > b
	end)

	local previous_file = nil
	local previous_date = nil
	for _, file in ipairs(files) do
		local file_date = vim.fn.fnamemodify(file, ":t:r")
		if file_date < today then
			previous_file = file
			previous_date = file_date
			break
		end
	end

	if not previous_file or vim.fn.filereadable(previous_file) ~= 1 then
		return nil, "No previous note found for TODO transfer"
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
		if line:match("^# ") then
			table.insert(todos_section, line)
		end
		if line:match("^## TODOs") then
			in_todos = true
			table.insert(todos_section, line)
		elseif in_todos and line:match("^## ") then
			break
		elseif in_todos then
			if line:match("^%- %[ %]") then
				insert_pending_sub_bullets()
				in_checked_item = false
				table.insert(todos_section, line)
			elseif line:match("^%- %[X%]") or line:match("^%- %[x%]") then
				insert_pending_sub_bullets()
				in_checked_item = true
			else
				if line:match("^###") or line:match("^%S*$") then
					insert_pending_sub_bullets()
					in_checked_item = false
				end

				if not in_checked_item then
					if line:match("^%s%s%- ") then
						last_sub_bullet_section = { line }
					elseif line:match("^%s%s%s+%- ") then
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

	if next(last_sub_bullet_section) ~= nil then
		vim.list_extend(todos_section, last_sub_bullet_section)
	end

	insert_recurring_tasks(todos_section, today, previous_date)

	if #todos_section == 0 then
		return nil, "No TODOs found to transfer"
	end

	local todo_count = 0
	for _, line in ipairs(todos_section) do
		if line:match("^%- %[ %]") then
			todo_count = todo_count + 1
		end
	end

	return {
		content = todos_section,
		file = today_file,
		todo_count = todo_count,
		previous_date = previous_date,
	}
end

local function transfer_todos_from_previous_day()
	local result, err = generate_daily_note_content()
	if not result then
		vim.notify(err, vim.log.levels.INFO)
		return
	end

	vim.fn.writefile(result.content, result.file)
	vim.notify(
		string.format("Transferred %d TODO items from %s", result.todo_count, result.previous_date),
		vim.log.levels.INFO
	)
end

local function dry_run_daily_note()
	local result, err = generate_daily_note_content(true)
	if not result then
		print("Error: " .. err)
		return
	end

	print("=== Daily Note Dry Run ===")
	print("File: " .. result.file)
	print("TODO Count: " .. result.todo_count)
	print("Previous Date: " .. result.previous_date)
	print("\n=== Content ===")
	for _, line in ipairs(result.content) do
		print(line)
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

		-- Dry-run command
		vim.api.nvim_create_user_command("ObsidianDailyDryRun", dry_run_daily_note, {})
	end,
}
