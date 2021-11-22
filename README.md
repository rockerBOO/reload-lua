# reload-lua

Reloads all your lua with helpful tooling.

## What?

Currently more an idea than a real thing but I have outlined what it would do.

- lua/vimscript variables to setup what to reload
- Use `~/.config/nvim/` like folder to index possible package paths to reload automatically.
  - Configure a autocmd on saving .lua files to reload the relevant set.
- Use plugin manager directory pathing to unload all lua
- Create a function to call for custom support
- On reload callback function for things like setup
- Unload ALL packages, can cause problems?
- Reload files in places like `plugin/reload_lua.lua`? 

The basic idea is to allow a scaling up from configuration to full control
of reload process. Automate local and plugin reloading using interfacing
with plugin managers (VimPlug, Packer.nvim, others).

Using `:ReloadLua` or `:ReloadLuaStart` or `:ReloadLua local`

for example would

1. reload all relevant neovim lua directories
2. start a reload server (listening for file updates in all relevant neovim lua directories)
3. reload lua files in local neovim config (`~/.config/nvim` or relevant neovim variable)

## Why?

Right now there is no common tooling for reloading. It also requires manual effort
to maintain all the relevant pieces to properly unload what you want to unload. Because of luajit
it can be very affordable to reload the packages when working with your config.

Finding paths to your local files takes using other plugins to control this. If you are working on a
plugin you will want to reload quickly. Support simple `:ReloadLua %` to unload `package.path`.

Ideally you could use it minimally with setting vimscript global variables. (shown here in lua)

- `vim.g.reloadlua.autocmds = false`
- `vim.g.reloadlua.mappings = false`

```lua
require('reload-lua').on_reload(function(event)
	-- event
	-- for example require('setup').setup()
end)
```

## Autocmds

On saving a lua file we should be able to automatically reload, opt in.

```
if vim.g.reloadlua.autocmds then
	vim.cmd[[autocmd BufPostWrite .lua :ReloadLua<cr>]]
end
```

## Mappings

Set binding, mode for mapping, opt in.

```
if vim.g.reloadlua.mappings then
	vim.cmd[[nnoremap <leader>asdf :ReloadLua<cr>]]
end
```

## on_reload

Fire event after reloading.

```lua
require('reload-lua').on_reload(function(event)
	-- event.paths
end)
```
