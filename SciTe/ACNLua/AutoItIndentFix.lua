--------------------------------------------------------------------------------
-- This library helps fix indenting issues with AutoIt code..  SciTE doesn't
-- always indent how AutoIt code flows so this fixes some common issues.
--
-- Current issues addressed:
--	The first Case statement is normally indented wrong.
--	Lines after single line If statements have the correct indentation.
--------------------------------------------------------------------------------
AutoItIndentFix = EventClass:new(Common)

--------------------------------------------------------------------------------
-- OnStartup()
--
-- Initializes object variables.
--------------------------------------------------------------------------------
function AutoItIndentFix:OnStartup()
	self.VK_RETURN = 0x0D

	-- The number of lines to look-back when trying to determine indentation.
	self.LookBack = 5

	-- The keywords which are statement endings.  See LoadEndStatements()
	-- for a property that may need to be user configured.
	self.EndStatements = self:LoadEndStatements()
end	-- OnStartup()

--------------------------------------------------------------------------------
-- OnKey(code)
--
-- Fixes issues with auto-indent when Return is pressed.
--
-- Parameters:
--	code - The keycode for the key pressed.
--
-- Returns:
--	The value true if default behavior needs blocked.
--	The value false if default behavior doesn't need blocked.
--------------------------------------------------------------------------------
function AutoItIndentFix:OnKey(code)
	-- We have a single return point from the code so we use this variable to
	-- hold the return value.  We have a single return point because all the
	-- fixes need to be executed, some keywords have multiple fixes applied to
	-- them.
	local return_value = false
	-- We check to see if return was used but we only want to intercept it if
	-- the AutoIt lexer is active and no AutoComplete is showing.
	if code == self.VK_RETURN and self:IsLexer(SCLEX_AU3) and not editor:AutoCActive() then
		-- At this point, we are still on the line where return was pressed.
		local line = editor:LineFromPosition(editor.CurrentPos)
		local if_pattern = "^%s*[Ii][Ff].-[Tt][Hh][Ee][Nn]%s*[^;%s]+"

		-- Auto-Indent should only occur if the caret is after the first word.
		local unused1, unused2, word_end = self:MatchWordAtStart("", line)
		if editor.CurrentPos < word_end then
			-- This is an allowed return because in this case, we want to do
			-- NOTHING.
			return false
		end

		editor:BeginUndoAction()
		-- Look for a single-line If...Then statement.  The pattern also detects
		-- when a multi-line If statement is used with a comment after Then.
		-- In this case the statement is still treated like a multi-line If.
		if self:MatchWordAtStart("If", line) then
			if string.find(editor:GetLine(line), if_pattern) then
				editor:NewLine() -- Insert the newline ourself.
				editor:BackTab()
				return_value = true
			end
		end

		-- Look for the first Case statement after a Select/Switch statement.
		if (self:MatchWordAtStart("Case", line)) then
			for i = 1, self.LookBack do
				local line_prev = line - i
				-- This isn't the first Case statement so do nothing.
				if self:MatchWordAtStart("Case", line_prev) then
					break
				end
				if self:MatchWordAtStart("Select", line_prev) or self:MatchWordAtStart("Switch", line_prev) then
					editor:NewLine() -- Insert the newline ourself.
					editor:LineUp()
					editor:Home()
					editor:Tab()
					editor:LineDown()
					editor:Tab()
					editor:LineEnd()
					return_value = true
				end
			end
		end

		-- Look for EndSelect/EndSwitch and take it back in line with Select
		if self:MatchWordAtStart("EndSelect", line) or self:MatchWordAtStart("EndSwitch", line) then
			local found = false
			for i = 1, self.LookBack do
				local line_prev = line - i
				if self:MatchWordAtStart("Case", line_prev) then
					-- Found a case statement, break and fix indentation.
					found = true
					break
				elseif self:MatchWordAtStart("Select", line_prev) or self:MatchWordAtStart("Switch", line_prev) then
					-- We found a Select/Switch statement, SciTE will do the right thing.
					break
				end
			end
			if found then
				-- If we are here, we need to adjsut the indentation.
				editor:NewLine() -- Insert the newline ourself.
				editor:LineUp()
				editor:Home()
				editor:BackTab()
				editor:LineDown()
				editor:BackTab()
				editor:LineEnd()
				return_value = true
			end
		end

		-- Fix statement ends when previous end was a single-line If
		local unused1, unused2, unused3, word = self:MatchWordAtStart("", line)
		if word and self.EndStatements[word:lower()] then
			for i = 1, self.LookBack do
				local line_prev = line - i
				-- Scan back over empty lines.
				if editor.LineEndPosition[line_prev] ~= editor.LineIndentPosition[line_prev] then
					-- We found a non-empty line, see if it's an If statement.
					if self:MatchWordAtStart("If", line_prev) then
						-- We found an If statement, see if it's a single line.
						if string.find(editor:GetLine(line_prev), if_pattern) then
							-- We found a single line If statement, fix up the
							-- closing statement's indentation.
							editor:NewLine()
							editor:LineUp()
							editor:Home()
							editor:BackTab()
							editor:LineDown()
							editor:BackTab()
							editor:LineEnd()
							return_value = true
						end
					end
					-- We break if we found a non-empty line at all.
					break
				end
			end
		end
		editor:EndUndoAction()
	end
	return return_value
end -- OnKey()

--------------------------------------------------------------------------------
-- LoadEndStatements()
--
-- Loads the AutoIt end statements into a table.
--
-- Returns:
--	A table containing the end statements. The keys are the statements, the
--	values are not used.
--------------------------------------------------------------------------------
function AutoItIndentFix:LoadEndStatements()
	-- This may need changed depending on the configuration.
	local text = props["block.end.$(au3)"]
	-- Store the names in a table.
	local data = { }
	-- Iterate over all words, clean them up and put them in the table.
	for word in text:gmatch("%a+") do
		-- We store the words in lower case.  This has the side effect of
		-- removing duplicate words.
		data[word:lower()] = true
	end
	return data
end	-- LoadEndStatements()
