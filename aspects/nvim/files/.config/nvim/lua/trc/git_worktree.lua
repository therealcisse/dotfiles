local status_ok, worktree = pcall(require, "git-worktree")
if not status_ok then
  return
end

worktree.setup{
    -- change_directory_command = <str> -- default: "cd",
    -- update_on_change = <boolean> -- default: true,
    -- update_on_change_command = <str> -- default: "e .",
    -- clearjumps_on_change = <boolean> -- default: true,
    -- autopush = <boolean> -- default: false,
}

worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
    vim.notify("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)
