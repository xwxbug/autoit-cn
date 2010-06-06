--------------------------------------------------------------------------------
-- This library provides some convenience when working in AutoIt scripts.  It
-- causes the AutoComplete and CallTips() to behave more intelligently.
--------------------------------------------------------------------------------
AutoItAutoComplete = EventClass:new(Common)

--------------------------------------------------------------------------------
-- OnStartup()
--
-- Initializes variables.
--------------------------------------------------------------------------------
function AutoItAutoComplete:OnStartup()
	-- Variable mappings for SciTE menu commands.
	self.IDM_SHOWCALLTIP = 232
	self.IDM_COMPLETE = 233
	self.IDM_COMPLETEWORD = 234

	-- List of "valid" styles as used by IsValidStyle().
	self.style_table =
	{
		SCE_AU3_COMMENTBLOCK,
		SCE_AU3_COMMENT,
		SCE_AU3_STRING,
		SCE_AU3_SPECIAL,
		SCE_AU3_COMOBJ,
		SCE_AU3_VARIABLE
	}
end	-- OnStartup()

--------------------------------------------------------------------------------
-- OnChar(c)
--
-- Controls showing and hiding of AutoComplete and CallTips.
--
-- Parameters:
--	c - The character typed.
--------------------------------------------------------------------------------
function AutoItAutoComplete:OnChar(c)
	-- Make sure we only do this for the AutoIt lexer.
	if self:IsLexer(SCLEX_AU3) then
		if props['autocomplete.au3.disable'] == "1" then
			self:CancelAutoComplete()
			return false
		end
		-- Store information about the character 2 back from the current position.
		local style = editor.StyleAt[editor.CurrentPos-2]
		local tCharVal = editor.CharAt[editor:WordStartPosition(editor.CurrentPos)]
		if tCharVal < 0 then 
			tCharVal = 256 + tCharVal 
		end 
		local c2 = string.char(tCharVal)

		-- Show CallTip when a comma is typed to delimit function parameters.
		if ((c == "," or c == "(") and
			(self:IsValidStyle(style) or self:IsQuoteChar(c2)) and
			not editor:CallTipActive()) then
			-- start
				local toClose = { ['('] = ')'}
				local pos = editor.CurrentPos
				editor:ReplaceSel(toClose[c])
				editor:SetSel(pos, pos)
			-- end
				scite.MenuCommand(self.IDM_SHOWCALLTIP)
			return
		end
		
		-- start
		if (c == "'" or c == '"' or c == '[' or c == ']') and 
			(self:IsValidStyle(style) and self:IsValidVarChar(editor:textrange(editor.CurrentPos-2,editor.CurrentPos-1))) then
			-- start
				local toClose = { ['('] = ')', ['{'] = '}', ['['] = ']', ['"'] = '"', ["'"] = "'" }
				local pos = editor.CurrentPos
				editor:ReplaceSel(toClose[c])
				editor:SetSel(pos, pos)
			-- end
			return
		end
		-- end
		-- Show variables in AutoComplete.
		if (c == "$" and self:IsValidStyle(style)) then
			scite.MenuCommand(self.IDM_COMPLETEWORD)
			return
		end

		-- Show macros in AutoComplete.
		if (c == "@" and self:IsValidStyle(style)) then
			scite.MenuCommand(self.IDM_COMPLETE)
			return
		end

		-- Skip showing AutoComplete on _ as the first character.
		if c == "_" and editor:WordStartPosition(editor.CurrentPos) + 1 == editor.CurrentPos then
			self:CancelAutoComplete()
			return true
		end

		-- Ensure the character is a valid function character.
		if not self:IsValidFuncChar(c) then
			return
		end

		-- Cancels AutoComplete if the previous character is a period.  It means
		-- we're typing a COM method but the style isn't set yet.
		if c2 == "." then
			return self:CancelAutoComplete()
		end

		-- Show AutoComplete if it isn't showing already.
		if not editor:AutoCActive() then
			scite.MenuCommand(self.IDM_COMPLETE)
			-- fall through
		end

		-- Last attempt to show AutoComplete.
		if not editor:AutoCActive() then
			scite.MenuCommand(self.IDM_COMPLETEWORD)
			return
		end
		return false 
	end
end	-- OnChar()

--------------------------------------------------------------------------------
-- IsValidStyle(style)
--
-- Checks if the style is _not_ in the table.
--
-- Parameters:
--	style - The style to check.
--
-- Returns:
--	The value true is returned if the style is _not_ in the table.
--	The value false is returned if the style is in the table.
--------------------------------------------------------------------------------
function AutoItAutoComplete:IsValidStyle(style)
	if self.style_table then
		for i, v in ipairs(self.style_table) do
			if style == v then
				return false
			end
		end
	end
	return true
end	-- IsValidStyle()

--------------------------------------------------------------------------------
-- IsValidFuncChar(c)
--
-- Checks to to see if a character is a valid function name character.
--
-- Parameters:
--	c - The character to check.
--
-- Returns:
--	The value true is returned if the charcter is a valid function character.
--	The value false is returned if the characer is not valid.
--------------------------------------------------------------------------------
function AutoItAutoComplete:IsValidFuncChar(c)
	return string.find(c, "[_%w]") ~= nil
end	-- IsValidFuncChar()

--------------------------------------------------------------------------------
-- IsQuoteChar(c)
--
-- Checks to see if a character is a single (') or double (") quote.
--
-- Parameters:
--	c - The character to check.
--
-- Returns:
--	The value true is returned if the character is a quote character.
--	The value false is returned if the character is not a quote character.
--------------------------------------------------------------------------------
function AutoItAutoComplete:IsQuoteChar(c)
	return string.find(c, "[\"\']") ~= nil
end	-- IsQuoteChar()


--------------------------------------------------------------------------------
-- IsValidVarChar(c)
--
-- Checks to to see if a character is a valid var or ',' character.
--
-- Parameters:
--	c - The character to check.
--
-- Returns:
--	The value true is returned if the charcter is a valid var or ',' character.
--	The value false is returned if the characer is not valid.
--------------------------------------------------------------------------------
function AutoItAutoComplete:IsValidVarChar(c)
	return string.find(c, "[a-zA-Z|\,]") ~= nil
end	-- IsValidFuncChar()