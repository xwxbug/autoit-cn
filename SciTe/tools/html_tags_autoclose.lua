-- Scite Xml Autocompletion
-- automatically closes tags and quotes attributes in XHTML and any XML files
-- executing if property tags.autoclose=1 (see file SciTEGlobal.properties)
-- Author: Romain Vallet (http://lua-users.org/wiki/SciteXmlAutocompletion)
-- Modified by: VladVRO
-----------------------------------------------

HTML_SINGLE_TAGS_LIST = {
    ["br"] = true,
    ["hr"] = true,
    ["img"] = true,
    ["input"] = true,
    ["meta"] = true,
}

function XMLTagsAutoClose (c)
    local nLexer = editor.Lexer
    if nLexer ~= 4 and nLexer ~= 5 then return end
    -- tag completion
    local pEnd = editor.CurrentPos - 1
    if pEnd < 1 then return end
    local ch = editor.CharAt[pEnd]
    if ch == 62 then -- ">"
        local nStyle = editor.StyleAt[pEnd - 1]
        if nStyle > 8 then return end
        local nLastChar = editor.CharAt[pEnd - 1]
        if nStyle == 6 and nLastChar ~= 34 then return end
        if nStyle == 7 and nLastChar ~= 39 then return end
        if nLastChar == 47 or nLastChar == 37 or nLastChar == 60 or nLastChar == 63 then return end
        local pStart = pEnd
        repeat
            pStart = pStart - 1
            if (editor.CharAt[pStart] == 32) then
                pEnd = pStart
            end
        until editor.CharAt[pStart] == 60 or pStart == 0
        if editor.CharAt[pStart + 1] == 47 then return end
        if pStart == 0 and editor.CharAt[pStart] ~= 60 then return end
        local tag = editor:textrange(pStart + 1, pEnd)
        if nLexer == 4 and HTML_SINGLE_TAGS_LIST[tag] then return end -- exclude html single tags
        editor:BeginUndoAction()
        editor:InsertText(editor.CurrentPos, "</" .. tag .. ">")
        editor:EndUndoAction()
    end

    -- attribute quotes
    if ch == 61 then -- "="
        local nStyle = editor.StyleAt[editor.CurrentPos - 2]
        if nStyle == 3 or nStyle == 4 then
            editor:BeginUndoAction()
            editor:InsertText(editor.CurrentPos, "\"\"")
            editor:GotoPos(editor.CurrentPos + 1)
            editor:EndUndoAction()
        end
    end
end

-- Добавляем свой обработчик события OnChar
local old_OnChar = OnChar
function OnChar(char)
    local result
    if old_OnChar then result = old_OnChar(char) end
    if props['macro-recording'] ~= '1' and tonumber(props['tags.autoclose']) == 1 then
        if XMLTagsAutoClose(char) then return true end
    end
    return result
end
