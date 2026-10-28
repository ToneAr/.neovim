-- wolframscript is often not on PATH on macOS, so look inside the app bundles
local function find_wolframscript()
	if vim.fn.executable("wolframscript") == 1 then
		return "wolframscript"
	end
	if vim.fn.has("mac") == 1 then
		for _, app in ipairs({ "Wolfram", "Mathematica", "Wolfram Engine", "WolframScript" }) do
			local path = "/Applications/" .. app .. ".app/Contents/MacOS/wolframscript"
			if vim.fn.executable(path) == 1 then
				return path
			end
		end
	end
	return "wolframscript"
end

--- @type vim.lsp.Config
return {
	name = "wl_lsp",
	cmd = {
		find_wolframscript(),
		"-noinit",
		"-noprompt",
		"-nopaclet",
		"-noicon",
		"-nostartuppaclets",
		"-run",
		"'Needs[\"LSPServer`\"];LSPServer`StartServer[]'"
	},
	filetypes = { "wl", "wolfram" },
	root_markers = { 'PacletInfo.wl', 'PacletInfo.m', '.git' },
	single_file_support = true,
	-- root_dir = function(fname)
	-- 	if type(fname) ~= "string" then
	-- 		return nil
	-- 	end
	-- 	return vim.fs.root(fname, { "PacletInfo.wl", "PacletInfo.m", ".git" }) or vim.fs.dirname(fname)
	-- end,
}
