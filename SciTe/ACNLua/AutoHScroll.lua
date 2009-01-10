--------------------------------------------------------------------------------
-- This library automatically sizes the horizontal scrollbar for the editor and
-- output panes based on the longest line currently visible.
--------------------------------------------------------------------------------
AutoHScroll = EventClass:new()

--------------------------------------------------------------------------------
-- OnUpdateUI()
--
-- Update the horizontal scroll width for both the editor and output pane.
--------------------------------------------------------------------------------
function AutoHScroll:OnUpdateUI()
	self:SetWidth(editor)
	self:SetWidth(output)
end	-- OnUpdateUI()

--------------------------------------------------------------------------------
-- SetWidth(pane)
--
-- Sets the width of pane's horizontal scrollbar.
--
-- Parameters:
--	pane - Can be either editor or output.
--------------------------------------------------------------------------------
function AutoHScroll:SetWidth(pane)
	-- An interesting quirk, pane.FirstVisibleLine is 0-based but
	-- of course the display is 1-based.  Keep this in mind if
	-- debugging the line numbers and things look off-by-one.
	local longest_value = 0, longest_line, longest_temp
	local line

	-- Iterate over all the visible lines and find the longest.  Actually,
	-- we also iterate over the first non-visible line (at the bottom)
	-- as well just to prevent a loop where the scrollbar shows itself,
	-- obscures the line it's active for, then hides itself, then shows
	-- itself because the line becomes visible again, ad infinium.
	for line = pane.FirstVisibleLine, pane.FirstVisibleLine + pane.LinesOnScreen do
		-- Compute the longest line from the lines which are visible.
		-- We have to translate this to the actual document line,
		-- otherwise folding may affect which line we get.
		local doc_line = pane:DocLineFromVisible(line)
		longest_temp = pane:LineLength(doc_line)
		if longest_temp > longest_value then
			longest_value = longest_temp
			longest_line = doc_line
		end
	end

	-- If we have a really small longest_value, set the width to 0
	-- and return.  This doesn't seem to work correctly for the
	-- output pane.
	if longest_value <= 2 then
		pane.ScrollWidth = 0
		return
	end

	-- Get the start of the line, this is used to retrieve the entire line's text.
	local line_start = pane:PositionFromLine(longest_line)
	-- This variable stores the position of the first non-whitespace character.
	local line_pos = pane.LineIndentPosition[longest_line + 2]
	-- We want to use a non-whitespace style if we can.
	local style = pane.StyleAt[line_pos]
	-- We don't want to grab the newlines so use this confusing code
	-- to strip 1 or 2 characters off the length (Really just a ternary).
	local adjust = (pane.EOLMode == 0 and 2) or 1
	-- Retrieve the line's text so we can calculate the width.
	local line_data = pane:textrange(line_start, (line_start + longest_value) - adjust)
	-- TextWidth() doesn't handle tabs, so, we replace tabs with spaces set to the
	-- indent size.
	line_data = line_data:gsub("\t", string.rep(" ", pane.Indent))
	-- Get an estimated width of the line.  We iterate all styles and pick the longest.
	local width = 0, width_temp
	local i
	for i = 1, 32 do
		width_temp = pane:TextWidth(i, line_data)
		if width_temp > width then
			width = width_temp
		end
	end

	-- Set the new width.  Hopefully it will be enough.
	pane.ScrollWidth = width
end	-- SetWidth()
