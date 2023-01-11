local cfg = {
  setopt = true,

  order = "FNSs",
  --- The click actions have the following signature:
  ---@param args (table): {
  ---   minwid = minwid,            -- 1st argument to 'statuscolumn' %@ callback
  ---   clicks = clicks,            -- 2nd argument to 'statuscolumn' %@ callback
  ---   button = button,            -- 3rd argument to 'statuscolumn' %@ callback
  ---   mods = mods,                -- 4th argument to 'statuscolumn' %@ callback
  ---   mousepos = f.getmousepos()  -- getmousepos() table, containing clicked line number/window id etc.
  --- }
  Lnum = function(args)
    if args.button == "l" and args.mods:find("c") then
      print("I Ctrl-left clicked on line "..args.mousepos.line)
    end
  end,
}

require("statuscol").setup(cfg)
