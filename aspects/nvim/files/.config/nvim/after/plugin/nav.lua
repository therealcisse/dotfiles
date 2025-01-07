-- Function to get the window IDs in counter-clockwise order
local function get_counter_clockwise_windows()
  local current_win = vim.api.nvim_get_current_win()
  local windows = vim.api.nvim_list_wins()
  local ordered_windows = {}

  -- Find the index of the current window
  local current_index = 0
  for i, win in ipairs(windows) do
    if win == current_win then
      current_index = i
      break
    end
  end

  -- Rotate the list to start from the window after the current window (counter-clockwise)
  for i = 1, #windows do
    local index = (current_index - i) % #windows
    if index == 0 then
      index = #windows
    end
    table.insert(ordered_windows, windows[index])
  end

  return ordered_windows
end

-- Function to switch to the next window in counter-clockwise order
local function cycle_windows_counter_clockwise()
  local windows = get_counter_clockwise_windows()
  if #windows > 0 then
    vim.api.nvim_set_current_win(windows[1])
  end
end

-- Create the keymap
vim.keymap.set('n', '<Tab>', cycle_windows_counter_clockwise, { noremap = true, silent = true })

-- Optional: Shift+Tab to go clockwise
local function get_clockwise_windows()
  local current_win = vim.api.nvim_get_current_win()
  local windows = vim.api.nvim_list_wins()
  local ordered_windows = {}

  -- Find the index of the current window
  local current_index = 0
  for i, win in ipairs(windows) do
    if win == current_win then
      current_index = i
      break
    end
  end

  -- Rotate the list to start from the next window (clockwise)
  for i = 1, #windows do
    table.insert(ordered_windows, windows[(current_index + i -1) % #windows + 1])
  end

  return ordered_windows
end

local function cycle_windows_clockwise()
  local windows = get_clockwise_windows()
  if #windows > 0 then
    vim.api.nvim_set_current_win(windows[1])
  end
end

vim.keymap.set('n', '<S-Tab>', cycle_windows_clockwise, { noremap = true, silent = true })
