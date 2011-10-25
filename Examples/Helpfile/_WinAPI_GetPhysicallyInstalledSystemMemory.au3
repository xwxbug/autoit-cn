#Include <WinAPIEx.au3>

msgbox(0, 'PhysicallyInstalledSystemMemory ', _WinAPI_GetPhysicallyInstalledSystemMemory() / 1024 / 1024 & ' GB')

