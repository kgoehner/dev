-- ChangeBackground changes the background mode based on macOS's `Appearance`
-- setting. We also refresh the statusline colors to reflect the new mode.
function ChangeBackground()
	if os.execute("defaults read -g AppleInterfaceStyle") == "^Dark" then
		vim.opt.background = "dark" -- for the dark version of the theme
	else
		vim.opt.background = "light" -- for the light version of the theme
	end
	vim.cmd([[colorscheme solarized]])
end

-- Initialize the colorscheme for the first run
ChangeBackground()
