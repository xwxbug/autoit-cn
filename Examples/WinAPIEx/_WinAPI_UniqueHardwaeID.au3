#Include <WinAPIEx.au3>

Opt('MustDeclareVars', 1)

ConsoleWrite('Hardware1: ' & _WinAPI_UniqueHardwaeID() & @CR)
ConsoleWrite('Hardware2: ' & _WinAPI_UniqueHardwaeID(BitOR($UHID_MB, $UHID_BIOS)) & @CR)
ConsoleWrite('Hardware3: ' & _WinAPI_UniqueHardwaeID(BitOR($UHID_MB, $UHID_BIOS, $UHID_CPU)) & @CR)
ConsoleWrite('Hardware4: ' & _WinAPI_UniqueHardwaeID(BitOR($UHID_MB, $UHID_BIOS, $UHID_CPU, $UHID_HDD)) & @CR)
