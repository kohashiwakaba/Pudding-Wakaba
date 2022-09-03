local wakabadirectory = wakaba.DSS_DIRECTORY
local dssmod = wakaba.DSS_MOD

wakabadirectory.wakabainfos = {
  format = {
    Panels = {
      {
        Panel = dssmod.panels.main,
        Offset = Vector(-50, 0),
        Color = Color.Default,
      },
      {
          Panel = dssmod.panels.tooltip,
          Offset = Vector(180, -2),
          Color = 1
      }
    }
  },
  generate = function()
  end,
  gridx = maxCol,
  buttons = {}
}