-- Модуль translit.lua предназначен для транслитерации английских букв в русские
-- Version: 1.02
-- Author: HSolo
-- Подключение можно сделать похожим образом:
---------------------------------------------------------------------------------
--~ command.name.84.*=Translitiration
--~ command.84.*=dofile $(SciteDefaultHome)\tools\translit.lua
--~ command.mode.84.*=subsystem:lua,savebefore:no
--~ command.shortcut.84.*=Alt+Q
---------------------------------------------------

local translit = {
  ['a'] ="а", ['b'] ="б", ['v'] ="в", ['w'] ="в", ['g'] ="г", ['d'] ="д", ['e'] ="е", ['jo']="ё",
  ['yo']="ё", ['zh']="ж", ['z'] ="з", ['i'] ="и", ['j'] ="й", ['jj']="й", ['k'] ="к", ['l'] ="л",
  ['m'] ="м", ['n'] ="н", ['o'] ="о", ['p'] ="п", ['r'] ="р", ['s'] ="с", ['t'] ="т", ['u'] ="у",
  ['f'] ="ф", ['h'] ="х", ['x'] ="х", ['c'] ="ц", ['ch']="ч", ['sh']="ш", ['shh']="щ",['\'']="ь",
  ['y'] ="ы", ['\"']="ъ", ['~']="ъ",  ['je']="э", ['ju']="ю", ['yu']="ю", ['ja']="я", ['ya']="я"}

local function RusUpper(Ch)
  if string.byte(Ch) < 224 then return string.upper(Ch) end
  return string.char(string.byte(Ch)-32)
end

local function TranslitIT(s)
  if string.len(s) == 0 then return outstr end

  local pos = 1
  local outstr = ""
  local res
  local toFind

  while (pos <= string.len(s)) do
    local isCapital = true
    if string.sub(s, pos, pos) == string.lower(string.sub(s, pos, pos)) then isCapital = false end

    for i = 3, 1, -1 do
      toFind = string.lower(string.sub(s, pos, pos + i - 1))
      res = translit[toFind]
      if res ~= nil then
        if isCapital then res = RusUpper(res) end
        outstr = outstr..res
        pos = pos + string.len(toFind)
        break
      end
    end
    if res == nil then
      outstr = outstr..toFind
      pos = pos + 1
    end
  end
  return outstr
end

local str = ''
if editor.Focus then
  str = editor:GetSelText()
else
  str = props['CurrentSelection']
end
if (str == '') then
  str = editor:GetCurLine()
  editor:LineDelete()
end

local result = TranslitIT(str)
editor:ReplaceSel(result)
print(result)
