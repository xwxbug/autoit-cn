; Double click at the current mouse position.
MouseClick("left")
MouseClick("left")

; Double click at the x, y position of 0, 500.
MouseClick("left", 0, 500, 2)

; Double click at the x, y position of 0, 500. This is a better approach as it takes into account left/right handed users.
MouseClick("primary", 0, 500, 2)
