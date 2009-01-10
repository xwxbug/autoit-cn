--------------------------------------------------------------------------------
-- This library always loads the session file.  Normally SciTE will auto-load
-- the session file, however, if opening a file, the session would not be loaded.
-- This issue is addressed by this library.
--------------------------------------------------------------------------------
LoadSession = EventClass:new()

--------------------------------------------------------------------------------
-- OnStartup()
--
-- Always load the last session, even when opening a file.
--------------------------------------------------------------------------------
function LoadSession:OnStartup()
	if props["save.session.advanced"] == "1" then
		if props["session.loaded"] == "" then
			props["session.loaded"] = "1"
			scite.Open(props["FilePath"] .. "\nloadsession:" .. props["SciteUserHome"] .. "\\SciTE.session")
		end
	end
end	-- OnStartup()
