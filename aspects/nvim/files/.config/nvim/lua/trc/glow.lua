local status_ok, glowHover = pcall(require, "glow-hover")
if not status_ok then
  return
end

glowHover.setup {
        -- The followings are the default values
        max_width = 50,
        padding = 10,
        border = 'shadow',
        glow_path = 'glow'
    }
