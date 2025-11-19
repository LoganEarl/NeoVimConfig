return {
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local function spell_suggest_float()
        local word = vim.fn.expand("<cword>")
        local all_suggestions = vim.fn.spellsuggest(word)
        local suggestions = {}
        for i = 1, math.min(10, #all_suggestions) do
          suggestions[i] = all_suggestions[i]
        end
        
        if #suggestions == 0 then
          vim.notify("No spelling suggestions for '" .. word .. "'")
          return
        end

        local lines = {}
        for i, suggestion in ipairs(suggestions) do
          table.insert(lines, i .. ": " .. suggestion)
        end

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)

        local width = math.max(20, math.min(50, vim.fn.max(vim.fn.map(lines, 'len(v:val)')) + 2))
        local height = math.min(10, #lines)
        
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local win_pos = vim.fn.screenpos(0, cursor_pos[1], cursor_pos[2])
        
        local opts = {
          relative = 'editor',
          width = width,
          height = height,
          row = win_pos.row,
          col = win_pos.col,
          style = 'minimal',
          border = 'rounded',
          title = ' Spelling Suggestions ',
          title_pos = 'center'
        }

        local win = vim.api.nvim_open_win(buf, true, opts)
        
        vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
          callback = function()
            local line = vim.api.nvim_get_current_line()
            local choice = line:match("^(%d+):")
            if choice then
              vim.api.nvim_win_close(win, true)
              vim.cmd('normal! "_ciw' .. suggestions[tonumber(choice)])
            end
          end,
          noremap = true,
          silent = true
        })
        
        vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '', {
          callback = function()
            vim.api.nvim_win_close(win, true)
          end,
          noremap = true,
          silent = true
        })
        
        for i = 1, math.min(9, #suggestions) do
          vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), '', {
            callback = function()
              vim.api.nvim_win_close(win, true)
              vim.cmd('normal! "_ciw' .. suggestions[i])
            end,
            noremap = true,
            silent = true
          })
        end
      end

      vim.keymap.set('n', 'z=', spell_suggest_float, { desc = 'Spelling suggestions in floating window' })
      vim.keymap.set('n', '<leader>ss', function()
        vim.cmd('normal! ]s')
        spell_suggest_float()
      end, { desc = '[S]earch for [S]pelling errors' })
    end
  }
}