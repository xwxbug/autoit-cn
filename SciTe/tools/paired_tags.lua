--[[--------------------------------------------------
Paired Tags (логическое продолжение скриптов highlighting_paired_tags.lua и HTMLFormatPainter.lua)
Version: 2.2.1
Author: mozers™, VladVRO
------------------------------
Подсветка парных и непарных тегов в HTML и XML
В файле настроек задается цвет подсветки парных и непарных тегов

Скрипт позволяет копировать и удалять (текущие подсвеченные) теги, а также
вставлять в нужное место ранее скопированные (обрамляя тегами выделенный текст)

Внимание:
В скрипте используются функции из COMMON.lua (EditorMarkText, EditorClearMarks)

------------------------------
Подключение:
Добавить в SciTEStartup.lua строку:
	dofile (props["SciteDefaultHome"].."\\tools\\paired_tags.lua")
Добавить в файл настроек параметр:
	hypertext.highlighting.paired.tags=1
Дополнительно можно задать стили используемых маркеров (1 и 2):
	find.mark.1=#0099FF
	find.mark.2=#FF0000 (если этот параметр не задан, то непарные теги не подсвечиваются)

Команды копирования, вставки, удаления тегов добавляются в меню Tools обычным порядком:
	tagfiles=$(file.patterns.html);$(file.patterns.xml)

	command.name.5.$(tagfiles)=Copy Tags
	command.5.$(tagfiles)=CopyTags
	command.mode.5.$(tagfiles)=subsystem:lua,savebefore:no
	command.shortcut.5.$(tagfiles)=Alt+C

	command.name.6.$(tagfiles)=Paste Tags
	command.6.$(tagfiles)=PasteTags
	command.mode.6.$(tagfiles)=subsystem:lua,savebefore:no
	command.shortcut.6.$(tagfiles)=Alt+P

	command.name.7.$(tagfiles)=Delete Tags
	command.7.$(tagfiles)=DeleteTags
	command.mode.7.$(tagfiles)=subsystem:lua,savebefore:no
	command.shortcut.7.$(tagfiles)=Alt+D

Для быстрого включения/отключения подсветки можно добавить команду:
	command.checked.8.$(tagfiles)=$(hypertext.highlighting.paired.tags)
	command.name.8.$(tagfiles)=Highlighting Paired Tags
	command.8.$(tagfiles)=highlighting_paired_tags_switch
	command.mode.8.$(tagfiles)=subsystem:lua,savebefore:no
--]]----------------------------------------------------

local t = {}
-- t.tag_start, t.tag_end, t.paired_start, t.paired_end  -- positions
-- t.begin, t.finish  -- contents of tags (when copying)
local old_current_pos

function CopyTags()
	local tag = editor:textrange(t.tag_start, t.tag_end+1)
	if t.paired_start~=nil then
		local paired = editor:textrange(t.paired_start, t.paired_end+1)
		if t.tag_start < t.paired_start then
			t.begin = tag
			t.finish = paired
		else
			t.begin = paired
			t.finish = tag
		end
	else
		t.begin = tag
		t.finish = nil
	end
end

function PasteTags()
	if t.begin~=nil then
		if t.finish~=nil then
			local sel_text = editor:GetSelText()
			editor:ReplaceSel(t.begin..sel_text..t.finish)
			if sel_text == '' then
				editor:GotoPos(editor.CurrentPos - #t.finish)
			end
		else
			editor:ReplaceSel(t.begin)
		end
	end
end

function DeleteTags()
	if t.tag_start~=nil then
		editor:BeginUndoAction()
		if t.paired_start~=nil then
			if t.tag_start < t.paired_start then
				editor:SetSel(t.paired_start, t.paired_end+1)
				editor:DeleteBack()
				editor:SetSel(t.tag_start, t.tag_end+1)
				editor:DeleteBack()
			else
				editor:SetSel(t.tag_start, t.tag_end+1)
				editor:DeleteBack()
				editor:SetSel(t.paired_start, t.paired_end+1)
				editor:DeleteBack()
			end
		else
			editor:SetSel(t.tag_start, t.tag_end+1)
			editor:DeleteBack()
		end
		editor:EndUndoAction()
	end
end

function highlighting_paired_tags_switch()
	local prop_name = 'hypertext.highlighting.paired.tags'
	props[prop_name] = 1 - tonumber(props[prop_name])
	EditorClearMarks(1)
	EditorClearMarks(2)
end

local function PairedTagsFinder()
	local current_pos = editor.CurrentPos
	if current_pos == old_current_pos then return end
	old_current_pos = current_pos

	EditorClearMarks(1)
	EditorClearMarks(2)

	t.tag_start = nil
	t.tag_end = nil
	t.paired_start = nil
	t.paired_end = nil

	local tag_start = editor:findtext("[<>]", SCFIND_REGEXP, current_pos, 0)
	if tag_start == nil then return end
	if editor.CharAt[tag_start] ~= 60 then return end
	if editor.StyleAt[tag_start+1] ~= 1 then return end
	if tag_start == t.tag_start then return end
	t.tag_start = tag_start

	t.tag_end = editor:findtext("[<>]", SCFIND_REGEXP, current_pos, editor.Length)
	if t.tag_end == nil then return end
	if editor.CharAt[t.tag_end] ~= 62 then t.tag_end = nil return end

	local dec, find_end
	if editor.CharAt[t.tag_start+1] == 47 then
		dec, find_end = -1, 0
	else
		dec, find_end =  1, editor.Length
	end

	-- Find paired tag
	local tag = editor:textrange(editor:findtext("\\w+", SCFIND_REGEXP, t.tag_start, t.tag_end))
	local count = 1
	local find_start = t.tag_start+dec
	repeat
		t.paired_start, t.paired_end = editor:findtext("</*"..tag.."[^>]*", SCFIND_REGEXP, find_start, find_end)
		if t.paired_start == nil then break end
		if editor.CharAt[t.paired_start+1] == 47 then
			count = count - dec
		else
			count = count + dec
		end
		if count == 0 then break end
		find_start = t.paired_start + dec
	until false

	if t.paired_start ~= nil then
		-- paint in Blue
		EditorMarkText(t.tag_start + 1, t.tag_end - t.tag_start - 1, 1)
		EditorMarkText(t.paired_start + 1, t.paired_end - t.paired_start - 1, 1)
	else
		if props["find.mark.2"] ~= '' then
			-- paint in Red
			EditorMarkText(t.tag_start + 1, t.tag_end - t.tag_start - 1, 2)
		end
	end
end

-- Add user event handler OnUpdateUI
local old_OnUpdateUI = OnUpdateUI
function OnUpdateUI ()
	local result
	if old_OnUpdateUI then result = old_OnUpdateUI() end
	if props['FileName'] ~= '' then
		if tonumber(props["hypertext.highlighting.paired.tags"]) == 1 then
			if editor.LexerLanguage == "hypertext" or editor.LexerLanguage == "xml" then
				PairedTagsFinder()
			end
		end
	end
	return result
end
