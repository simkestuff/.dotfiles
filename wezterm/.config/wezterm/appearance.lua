local wezterm = require("wezterm")
local module = {}

-- return true if system theme is dark
function module.is_dark()
	if wezterm.gui then
		print(wezterm.gui.get_appearance())
		return wezterm.gui.get_appearance():find("Dark")
	end
	return true
end

return module
