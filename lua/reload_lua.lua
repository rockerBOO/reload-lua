local reload_lua = {}

local handlers = {
	on_reload = {},
}

vim.g.reloadlua = {}

vim.g.reloadlua.autocmds = false
vim.g.reloadlua.mappings = false

reload_lua.autocmds = function()
	vim.cmd([[augroup ReloadLuaAutocmds
    au!
    aut BufWritePost *.lua lua require('reload_lua').reload()
  augroup end]])
end

reload_lua.mappings = function()
	print("mappings")
	vim.cmd([[nnoremap <leader>asdf :lua require('reload_lua').reload()<cr>]])
end

reload_lua.setup = function(opts)
	if vim.g.reloadlua.autocmds or opts.autocmds then
		reload_lua.autocmds()
	end

	if vim.g.reloadlua.mappings or opts.mappings then
		reload_lua.mappings()
	end
end

local find_files = function()
	-- TODO: use vim.loop for finding lua files for cross platform builtin support
	local result = vim.fn.system("fd -e lua . '/home/rockerboo/.config/nvim'")
	local results = {}

	if result == nil then
		print(" no results found")
		return results
	end

	for str in string.gmatch(result, "([^\n]*)\n?") do
		table.insert(results, str)
	end

	local result = vim.fn.system("fd -e lua . '/home/rockerboo/.config/local/share/nvim/site/pack/packer/opt/'")

	if result == nil then
		print(" no results found")
		return results
	end

	for str in string.gmatch(result, "([^\n]*)\n?") do
		table.insert(results, str)
	end

	return results
end

-- @param opts string, table
reload_lua.reload = function(opts)
	-- package.loaded
	local files = find_files()
	-- print(#files)
	package.loaded.reload_lua = nil
end

reload_lua.load_command = function(start_line, end_line, count, action, ...)
	local args = { ... }

	reload_lua.reload(action)
end

reload_lua.load_start_command = function(start_line, end_line, count, action, ...)
	local args = { ... }

	-- reload_lua.reload(action)
	vim.cmd([[echo "TODO start server" ]])
end

reload_lua.on_reload = function(func)
	table.insert(handlers.on_reload, func)
end

-- reload_lua.setup({
-- 	autocmds = true,
-- 	mappings = true,
-- })

return reload_lua
