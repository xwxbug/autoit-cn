-- «амена отступов в виде табул€торов на пробелы и наоборот
-- соответствие количества пробелов замен€ющих знак табул€ции беретс€ из ваших установок в .properties
-- mozersЩ icq#256106175

local sel_text = editor:GetSelText()
if sel_text == '' then
	line_start = 0
	line_end = editor.LineCount-1
else
	line_start = props["SelectionStartLine"] - 1
	line_end = props["SelectionEndLine"] - 2
end
local indent_char = nil
editor:BeginUndoAction()
for line_num = line_start, line_end do
	local line = editor:GetLine (line_num)
	if line ~= nil then
		local len = editor.LineIndentation[line_num]
		if len ~= 0 then
			if indent_char == nil then
				indent_char = string.sub(line, 1, 1)
			end
			if indent_char == "\t" then
				indent = string.rep (" ", len)
			else
				indent = string.rep ("\t", len/editor.Indent)
			end
			editor.TargetStart = editor:PositionFromLine(line_num)
			editor.TargetEnd = editor.LineIndentPosition[line_num]
			editor:ReplaceTarget(indent)
		end
	end
end
editor.Indent = props["indent.size"]
editor:EndUndoAction()
