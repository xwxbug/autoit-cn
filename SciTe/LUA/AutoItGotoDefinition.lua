--------------------------------------------------------------------------------
-- This library provides a fully implemented function for jumping to an Autoit
-- function definition no matter which file it is located in.
--------------------------------------------------------------------------------
AutoItGotoDefinition = EventClass:new(Common)

--------------------------------------------------------------------------------
-- OnStartup()
--
-- Initializes the object variables.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:OnStartup()
	-- This variable defines the name of a property which contains a semi-colon
	-- delimited list of directories where #include files can be found.  For
	-- best results, user-defined paths should appear first and the Standard
	-- Library path should be last.  Customize this variable to be the name
	-- of the property exactly how it appears in the properties file.
	self.DirProp = "openpath.$(au3)"
	self.DirPropBeta = "openpath.beta.$(au3)"
	-- Specifies the marker type to use (default: Bookmark).
	self.Marker = 1
	-- Set this variable to true for debugging traces.
	self.Debug = false
end	-- OnStartup()

--------------------------------------------------------------------------------
-- JumpBack()
--
-- Jumps back to the place GotoDEfinition was invoked
--
-- Tool: AutoItGotoDefinition.JumpBack $(au3) savebefore:no Alt+shift+J
--------------------------------------------------------------------------------
function AutoItGotoDefinition:JumpBack()
	if props['SciteLastJumpFromFile'] ~= nil and props['SciteLastJumpFromFile'] ~= "" then
		self.filename = string.gsub(props['SciteLastJumpFromFile'],"(.-)|(.*)","%1")
		self.filepos = string.gsub(props['SciteLastJumpFromPos'],"(.-)|(.*)","%1")
		props['SciteLastJumpFromFile'] = string.gsub(props['SciteLastJumpFromFile'],"(.-)|(.*)","%2")
		props['SciteLastJumpFromPos'] = string.gsub(props['SciteLastJumpFromPos'],"(.-)|(.*)","%2")
		scite.Open(self.filename)
		editor:GotoPos(self.filepos)
		return
	end
end
--------------------------------------------------------------------------------
-- GotoDefinition()
--
-- Jumps to a function definition.
--
-- Tool: AutoItGotoDefinition.GotoDefinition $(au3) savebefore:yes Alt+G Goto Definition
--------------------------------------------------------------------------------
function AutoItGotoDefinition:GotoDefinition(version)
	-- Get the current word.
	local func = self:GetWord()
	if func == "" then
		print("Cursor not on any text.")
		return
	end

	-- Set up variables we'll be using throughout.
	local current = props["FilePath"]
	local found = false
	-- First we check to see if the original file contains the function.
	if self:ContainsFunction(func, current) and self:ShowFunction(func, current) then
		found = true
	else
		-- The original file doesn't contain the function.
		local directories = self:GetDirectories(version)
		local includes = self:GetIncludes(current)
		-- Iterate over the list of includes
		for k,v in self:NextInclude(includes) do
			-- If we've already processed a file, we skip it.  This presents a
			-- problem if there are 2 identicaly named files on the search path
			-- and both are in use in the current script.  This is extremely
			-- unlikely, however.
			if not v.Processed then
				v.Processed = true
				-- Define variables to control the for loop direction.
				local start, stop, step
				if v.IsLibrary then
					start = #directories
					stop = 1
					step = -1
				else
					start = 1
					stop = #directories
					step = 1
				end
				-- Loop through the directories in the specified direction.
				for i = start, stop, step do
					current = directories[i] .. k
					if self:FileExists(current) then
						self:DebugPrint("Scanning: " .. current)
						if self:ContainsFunction(func, current) and self:ShowFunction(func, directories[i] .. k) then
							-- If we found and showed the function, stop
							-- processing.
							found = true
							break
						else
							-- We didn't find the function, get the includes in
							-- this file and continue searching.
							includes = self:GetIncludes(current, includes)
						end
					end
				end
			end
			-- If we found the function, we need to stop looking.
			if found then
				break
			end
		end
	end

	-- The function wasn't found.
	if not found then
		print("Unable to find function definition: " .. func)
	end
end	-- GotoDefinition()

--------------------------------------------------------------------------------
-- GetIncludes(file, files)
--
-- Parses file for all #include statements adding each new file to the files
-- 	table.
--
-- Parameters:
--	file - The file to process.
--	files - The table of existing files to add to.  No entry will appear twice
--		or be altered if it's already in the list.
--
-- Returns:
--	A table of found files (or an empty table).  The table keys are the name
--	of the file.  The value for a key is another table containing the members
--	IsLibrary which is a flag to determine which direction searching should
--	begin and the member Processed which should be set to true once the file
--	has been scanned.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:GetIncludes(file, files)
	-- We want to keep a running list of files if possible, but if this is the
	-- first call we may need to create the table.
	if not files then
		files = { }
	end
	-- Partial pattern to shorten the real patterns.
	local pattern_prefix = "^%s*#[Ii][Nn][Cc][Ll][Uu][Dd][Ee]%s*"
	-- Look for <> syntax
	local pattern_library = pattern_prefix .. "<%s*([^>]+)>%s*$"
	-- Look for "" or '' syntax
	local pattern_local = pattern_prefix .. "['\"]%s*([^'\"]+)['\"]%s*$"
	-- Iterate the file looking for #include statements.  If we find a match,
	-- we set the key to the name of the file and the value to a table with
	-- members used during searching.
	for line in io.lines(file) do
		-- Force lower case
		local include = line:match(pattern_library)
		if include and not files[include] then
			self:DebugPrint("Include: " .. include)
			files[include] = { IsLibrary=true, Processed=false }
		else
			include = line:match(pattern_local)
			if include and not files[include] then
				self:DebugPrint("Include: " .. include)
				files[include] = { IsLibrary=false, Processed=false }
			end
		end
	end
	return files
end	-- GetIncludes()

--------------------------------------------------------------------------------
-- GetDirectories()
--
-- Returns a table of directories AutoIt searches.
--
-- Returns:
--	An indexed table of directories to search.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:GetDirectories(version)
	local directories = { }
	-- Always put the local directory first.
	table.insert(directories, props["FileDir"] .. "\\")
	-- Idealy, openpath will define user-defined directories first and the
	-- AutoIt directory last.
	if version ~= "beta" then 
		for directory in string.gmatch(props[self.DirProp], "([^;]+)") do
			table.insert(directories, directory)
			self:DebugPrint("directory: " .. directory)
		end
	else
		for directory in string.gmatch(props[self.DirPropBeta], "([^;]+)") do
			table.insert(directories, directory)
			self:DebugPrint("directory: " .. directory)
		end
	end
	-- Ensure all directories have a trailing backslash.
	for i,v in ipairs(directories) do
		if not v:find("\\$") then
			directories[i] = v .. "\\"
		end
	end
	-- Add an empty directory so we can open absolute paths.
	table.insert(directories, "")
	-- Return the table.
	return directories
end	-- GetDirectories()

--------------------------------------------------------------------------------
-- ContainsFunction(func, file)
--
-- Checks to see if the specified function is in the file.
--
-- Parameters:
--	func - The function to look for.
--	file - The file to search in.
--
-- Returns:
--	The value true if the file contains the function defintion.
--	The value false if the file does not contain the function definition.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:ContainsFunction(func, file)
	local pos = 0
	local fp = io.open(file)
	if fp then
		-- Read the entire file
		local doc = fp:read("*a")
		fp:close()
		-- Force everything to lower case
		doc = doc:lower()
		func = func:lower()
		-- Look for the function.
		pos = doc:find("func " .. func .. "%s*%(")
	end
	return pos ~= 0 and pos ~= nil
end	-- ContainsFunction()

--------------------------------------------------------------------------------
-- ShowFunction(func, file)
--
-- Opens the file and jumps to the function definition.
--
-- Parameters:
--	func - The function to look for.
--	file - The file to search in.
--
-- Returns:
--	The value true if the function was shown.
--	The value false if the function was not shown.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:ShowFunction(func, file)
	if props['SciteLastJumpFromFile'] == nil or props['SciteLastJumpFromFile'] == "" then
		props['SciteLastJumpFromFile'] = string.gsub(props["FilePath"],"\\","\\\\") .. "|"
		props['SciteLastJumpFromPos'] = editor.CurrentPos .. "|"
	else
		props['SciteLastJumpFromFile'] = string.gsub(props["FilePath"],"\\","\\\\") .. "|" .. props['SciteLastJumpFromFile']
		props['SciteLastJumpFromPos'] = editor.CurrentPos .. "|" .. props['SciteLastJumpFromPos']
	end
	-- Open the file
	scite.Open(file)
	-- Get the text.
	local text = editor:GetText()
	-- Force to lower case
	text = text:lower()
	func = func:lower()
	local pos = 0
	-- Look for the function definition outside of comments.
	repeat
		pos = text:find("func " .. func .. "%s*%(", pos + 1)
	until not pos or (editor.StyleAt[pos] ~= SCE_AU3_COMMENTBLOCK and
		editor.StyleAt[pos] ~= SCE_AU3_COMMENT)
	-- We found a function definition, set up a marker and go to the function.
	if pos then
		editor:GotoLine(editor:LineFromPosition(pos))
		editor:EnsureVisible(editor:LineFromPosition(pos))
	end
	return pos ~= 0 and pos ~= nil
end	-- ShowFunction()

--------------------------------------------------------------------------------
-- NextInclude(list)
--
-- For use in a for ... in loop.  Returns the necessary parameters to iterate
-- across the list of includes.  This function expects data as created by the
-- GetIncludes() function.
--
-- Parameters:
--	list - A list of includes as created by GetIncludes()
--
-- Returns:
--	An iterator function, the list and a nil.  Values required to perform for
--	loop iteration.
--------------------------------------------------------------------------------
function AutoItGotoDefinition:NextInclude(list)
	-- Simple iterator function to return the next unprocessed key,value pair.
	function Iter(list)
		for k,v in pairs(list) do
			if not v.Processed then
				return k, v
			end
		end
		return nil
	end
	-- Return the iterator function, the state (in this case, our list) and
	-- the initial iterator value (which we do not need or use).
	return Iter, list, nil
end	-- NextInclude()
