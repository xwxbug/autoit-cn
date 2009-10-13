--[[--------------------------------------------------
css_formatter.lua
Author: mozersЩ
Version: 1.2
------------------------------------------------------
ѕриводит выделенную таблицу стилей к виду:
tag {
	prop: value;	/* comment */
	prop: value;	/* comment */
}
ѕараметры css.format.sort.tags и css.format.sort.props определ€ют
сортировать или нет селекторы классов и отдельные свойства

------------------------------------------------------
Connection:
Set in a file .properties:
  css.patterns=*.css;*.html;*.htm;*.hta
  command.name.14.$(css.patterns)=Format Selected StyleSheet
  command.14.$(css.patterns)=dofile $(SciteDefaultHome)\tools\css_formatter.lua
  command.mode.14.$(css.patterns)=subsystem:lua,savebefore:no

  css.format.sort.tags=1
  css.format.sort.props=1
--]]--------------------------------------------------

local text = props["CurrentSelection"]
if text == '' then return end
local t_style = {}

-- Create table of styles
for tag, prop_value_comment in string.gmatch(text, "%s*([^{]-)%s*{(.-)}") do
	local t_props = {}
	local _start, _end, _prop, _value, _comment
	local _prop0, _value0
	_end = 0
	while true do
		_init = _end + 1
		_start, _end, _prop, _value = prop_value_comment:find("%s*([%a-_]-):%s*([^;]+);%s*", _init)
		if _start ~= nil then
			_comment = prop_value_comment:sub(_init, _start-1)
		else
			_comment = prop_value_comment:sub(_init, #prop_value_comment):gsub('%s*$', '')
		end
		if _prop0 ~= nil then
			local p = {}
			p['prop'], p['value'], p['comment'] = _prop0, _value0, _comment
			t_props[#t_props+1] = p
		end
		if _start == nil then break end
		_prop0, _value0 = _prop, _value
	end
	local s = {}
	s['tag'], s['props'] = tag, t_props
	t_style[#t_style+1] = s
end

-- Sort tags
if tonumber(props['css.format.sort.tags']) then
	table.sort(t_style, function(a, b)
						-- #id and .class after tags
						local _a = a['tag']:gsub('^#', 'ю'):gsub('^%.', '€')
						local _b = b['tag']:gsub('^#', 'ю'):gsub('^%.', '€')
						return _a:upper() < _b:upper()
						end)
end

-- Print styles table
text = ''
for _, t_props in pairs(t_style) do
	if tonumber(props['css.format.sort.props']) then
		-- Sort props
		table.sort(t_props['props'], function(a, b) return a['prop']:upper() < b['prop']:upper() end)
	end
	local _style = ''
	for _, _props in pairs(t_props['props']) do
		_style = _style..'\t'.._props['prop']..': '.._props['value']..';'
		if _props.comment == '' then
			_style = _style..'\r\n'
		else
			_style = _style..'\t'.._props['comment']..'\r\n'
		end
	end
	text = text..t_props['tag']..' {\r\n'.._style..'}\r\n\r\n'
end

editor:ReplaceSel(text)
