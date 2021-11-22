command! -nargs=*  ReloadLua lua require('reload_lua').load_command(<line1>, <line2>, <count>, unpack({<f-args>}))

command! -nargs=*  ReloadLuaStart lua require('reload_lua').load_start_command(<line1>, <line2>, <count>, unpack({<f-args>}))

