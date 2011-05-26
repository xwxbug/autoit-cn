--------------------------------------------------------------------------------
-- This library automatically sizes the horizontal scrollbar for the editor and
-- output panes based on the longest line currently visible.
--------------------------------------------------------------------------------
AutoHScroll = EventClass:new()

--------------------------------------------------------------------------------
-- Declare a table to store per-pane cached line numbers.  This prevents the
-- scrollbar from constantly appearing and disappearing during editing.
--------------------------------------------------------------------------------
AutoHScroll.cache = { }

--------------------------------------------------------------------------------
-- Declare the debugging variable (Defaults to off).
--------------------------------------------------------------------------------
AutoHScroll.Debug = false

--------------------------------------------------------------------------------
-- Special variable that controls which pane will be debugged.  Only one pane
-- can be debugged at a time.  This value should be set to either editor or
-- output.
--------------------------------------------------------------------------------
AutoHScroll.DebugPane = editor

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
	-- Declare the variable used in the function.
	local width = 0, line, visible_line

	-- Iterate over all the visible lines.
	for visible_line = pane.FirstVisibleLine, pane.FirstVisibleLine + pane.LinesOnScreen do
		-- Convert the visible line into a document line.
		local line_temp = pane:DocLineFromVisible(visible_line)

		-- Get the width of the line based on the X coordinate of it's end
		-- position.  This provides a fast and accurate way of getting the
		-- width regardless of the styling the line may have.
		local width_temp = pane:PointXFromPosition(pane.LineEndPosition[line_temp])

		-- Test if the current line is longer than the current longest.
		if width_temp > width then
			-- Update the width.
			width = width_temp

			-- Update the line number.
			line = line_temp
		end
	end
	if line ~= nil then
		return -1
	end
	-- Test if the line number has changed compared to the cached line.
	if self.cache[pane] ~= line then
		-- Display debug diagnostics about the change.  The offset + 1 is due
		-- to the document lines being 0-based.  The or statement prevents
		-- an error on the first run when there is no cached pane data.
		self:DebugPrintEx(pane, "Old line: " .. (self.cache[pane] or "None") .. ", Old width: " .. pane.ScrollWidth .. ", New Line: " .. line .. ", New width: " .. width)

		-- Set the width.
		pane.ScrollWidth = width

		-- Cache the longest line to prevent future updates.
		self.cache[pane] = line
	end
end	-- SetWidth()

--------------------------------------------------------------------------------
-- DebugPrintEx(pane, s)
--
-- Set self.Debug = true to allow debug messages to print.  In addition,
-- self.DebugPane must be set to either editor or output in order for any
-- debugging to occur.  This is done to filter the messages so that they are
-- easier to understand.
--
-- Parameters:
--	pane - The pane currently being processed.
--	s - The string to print.
--------------------------------------------------------------------------------
function AutoHScroll:DebugPrintEx(pane, s)
	local pane_name = "Unknown"
	if pane == self.DebugPane then
		if pane == editor then
			pane_name = "Editor"
		elseif pane == output then
			pane_name = "Output"
		end
		return self:DebugPrint(pane_name .. ": " .. s)
	end
end	-- DebugPrintEx()
