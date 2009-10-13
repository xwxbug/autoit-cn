-- Code Poster HTML
-- Version: 1.4.4
-- Author: VladVRO
---------------------------------------------------
-- Description:
-- конвертирует выделенный текст или весь файл в HTML текст, используя
-- синтаксическую подсветку самого редактора (номер стиля) и таблицу цветов STYLES.
-- корректно работает для: C/C++, CSS, JavaScript, Lau, VB, VBscript, Properties

-- Для подключения добавьте в свой файл .properties следующие строки:
--  command.name.125.*=Преобразовать в HTML
--  command.125.*=dofile $(SciteDefaultHome)\tools\code-poster.lua
--  command.mode.125.*=subsystem:lua,savebefore:no

-- ремарки по использованию:
--  - в скрипте используется функция editor.LexerLanguage (сборка Ru-Board, http://scite.net.ru)
---------------------------------------------------

local STYLES = {
  comment = {color="008000", no=true},
  number = {color="AC00A9"},
  string = {color="9999CC", no=true},
  preproc = {color="7F7F00"},
  operator = {color="FF0000"},
  keyword = {color="0000DF"},
  keyword2 = {color="0080C0"},
  keyword3 = {color="8000FF"},
  keyword4 = {color="FF8000"},
  keyword5 = {color="660000"},
  keyword6 = {color="004080"},
  keyword7 = {color="408080"},
  keyword8 = {color="AAAA00"},
}
STYLES.default = {
  [1] = STYLES.comment,
  [2] = STYLES.comment,
  [3] = STYLES.comment,
  [4] = STYLES.number,
  [5] = STYLES.keyword,
  [6] = STYLES.string,
  [7] = STYLES.string,
  [8] = STYLES.string,
  [9] = STYLES.preproc,
  [10] = STYLES.operator,
  [13] = STYLES.keyword2,
  [14] = STYLES.keyword3,
  [15] = STYLES.keyword4,
  [16] = STYLES.keyword5,
  [17] = STYLES.keyword6,
  [18] = STYLES.keyword7,
  [19] = STYLES.keyword8,
}
STYLES.others = {
  [1] = STYLES.comment,
  [2] = {color="0080C0", no=true},
  [3] = STYLES.operator,
  [4] = STYLES.preproc,
  [5] = STYLES.keyword,
}
STYLES.props = STYLES.others
STYLES.vb = {
  [1] = STYLES.comment,
  [2] = STYLES.number,
  [3] = STYLES.keyword,
  [4] = STYLES.string,
  [5] = STYLES.preproc,
  [6] = STYLES.operator,
  [8] = STYLES.number,
  [10] = STYLES.keyword2,
  [11] = STYLES.keyword3,
  [12] = STYLES.keyword4,
}
STYLES.vbscript = STYLES.vb
STYLES.css = {
  [1] = STYLES.keyword,
  [3] = STYLES.keyword2,
  [5] = STYLES.operator,
  [6] = STYLES.keyword3,
  [8] = STYLES.string,
  [9] = STYLES.comment,
  [10] = STYLES.number,
  [12] = STYLES.preproc,
  [13] = STYLES.string,
  [14] = STYLES.string,
  [15] = STYLES.keyword4,
  [16] = STYLES.keyword5,
}
STYLES.cpp = {
  [1] = STYLES.comment,
  [2] = STYLES.comment,
  [3] = STYLES.comment,
  [4] = STYLES.number,
  [5] = STYLES.keyword,
  [6] = STYLES.string,
  [7] = STYLES.string,
  [8] = STYLES.string,
  [9] = STYLES.preproc,
  [10] = STYLES.operator,
  [13] = STYLES.keyword4,
  [14] = STYLES.keyword3,
  [15] = STYLES.comment,
  [16] = STYLES.keyword2,
  [17] = STYLES.comment,
  [18] = STYLES.comment,
}
STYLES.cppnocase = STYLES.cpp

local LEXSTYLES
local lex = editor.LexerLanguage
if lex == nil then
  LEXSTYLES = STYLES.others
else
  LEXSTYLES = STYLES[lex]
  if LEXSTYLES == nil then
    LEXSTYLES = STYLES.default
  end
end

local new = ""
local text = editor:GetSelText()
local line
if text == "" then
  editor:SelectAll()
  text = editor:GetSelText()
elseif string.len(text) ~= editor.Length then
  line = scite.SendEditor(SCI_LINEFROMPOSITION, editor.SelectionStart) + 1
end
local pos = editor.SelectionStart

local text = text.."\n"
for str in string.gfind(text, "([^\n]*)\n") do
  -- format next line
  local newstr = ""
  local fin = ""
  local len = string.len(str)
  if string.sub(str,len,len) == "\r" then
    len = len - 1
    str = string.sub(str,1,len)
    fin = "\r"
  end
  local style = LEXSTYLES[scite.SendEditor(SCI_GETSTYLEAT, pos)]
  local i0,i = 1,1
  while i <= len do
    local nstyle
    repeat
      pos = pos + 1
      i = i + 1
      nstyle = LEXSTYLES[scite.SendEditor(SCI_GETSTYLEAT, pos)]
    until nstyle ~= style or i > len
    local txt = string.sub(str,i0,i-1)
    i0 = i
    txt = string.gsub(txt, string.char(9), "&nbsp;&nbsp;") -- change tab to spaces
    txt = string.gsub(txt, string.char(32), "&nbsp;")
    if style ~= nil then
      if style.no then
--~         txt = "<p>"..string.gsub(txt,"%[(/*)no%]","[%1n[/no][no]o]").."</p>"
      end
      if style.color then
        txt = "<font color="..style.color..">"..txt.."</font>"
      end
    end
    newstr = newstr..txt
    style = nstyle
  end
  -- append line to formated text
  if new ~= "" then new = new.."<br>" end
  new = new..newstr..fin
  pos = pos + string.len(fin) + 1
end

-- add remarks
local header = ""
if props["FileNameExt"] ~= "" then
  header = "<b><font color=blue>"..props["FileNameExt"].."</font></b> "
  if line ~= nil then
    header = header.." <b><small>строка "..line.."</small></b> "
    -- remove empty line after code block
    local l = string.len(new)
    if string.sub(new,l,l) == "\n" then
      if string.sub(new,l-1,l-1) == "\r" then
        new = string.sub(new,1,l-2)
      else
        new = string.sub(new,1,l-1)
      end
    end
  end
end
local footer = " <font color=gray><i><small>Данный код внедрен в форум с помощью </small><a href=http://forum.ru-board.com/topic.cgi?forum=5&topic=3215&start=1558&limit=1&m=1#1><small>скрипта</small></a> <small><b>vladvro</b></small></i></font>"
new = header..'<div style="border: 1px solid black; background: white; padding: 10px; font:x-small Courier">\r\n'..new..'</div>\r\n'..footer

-- update text in editor
local ss = editor.SelectionStart
editor:ReplaceSel(new)
editor:SetSel(ss, ss+string.len(new))