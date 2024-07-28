local status, _ = pcall(vim.cmd("colorscheme nightfly"))
if not status then
	print("Colorscheme not found") -- print erro if colorscheme not installed
	return
end
