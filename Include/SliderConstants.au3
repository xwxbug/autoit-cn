#include-once

; ------------------------------------------------------------------------------
;
; AutoIt Version: 3.2
; Description:    Slider Constants
;
; ------------------------------------------------------------------------------

; Styles
Global Const $TBS_AUTOTICKS = 0x0001
Global Const $TBS_BOTH = 0x0008
Global Const $TBS_BOTTOM = 0x0000
Global Const $TBS_DOWNISLEFT = 0x0400
Global Const $TBS_ENABLESELRANGE = 0x20
Global Const $TBS_FIXEDLENGTH = 0x40
Global Const $TBS_HORZ = 0x0000
Global Const $TBS_LEFT = 0x0004
Global Const $TBS_NOTHUMB = 0x0080
Global Const $TBS_NOTICKS = 0x0010
Global Const $TBS_REVERSED = 0x200
Global Const $TBS_RIGHT = 0x0000
Global Const $TBS_TOP = 0x0004
Global Const $TBS_TOOLTIPS = 0x100
Global Const $TBS_VERT = 0x0002

; Custom Draw Values (Custom Draw values, for example, are specified in the dwItemSpec member of the NMCUSTOMDRAW structure)
Global Const $TBCD_CHANNEL = 0x3 ;Identifies the channel that the trackbar control's thumb marker slides along.
Global Const $TBCD_THUMB = 0x2 ;Identifies the trackbar control's thumb marker. This is the part of the control that the user moves
Global Const $TBCD_TICS = 0x1 ;Identifies the tick marks that are displayed along the trackbar control's edge

; Messages
Global Const $TWM_USER = 0x400 ; WM_USER
Global Const $TBM_CLEARSEL = ($TWM_USER + 19)
Global Const $TBM_CLEARTICS = ($TWM_USER + 9)
Global Const $TBM_GETBUDDY = ($TWM_USER + 33)
Global Const $TBM_GETCHANNELRECT = ($TWM_USER + 26)
Global Const $TBM_GETLINESIZE = ($TWM_USER + 24)
Global Const $TBM_GETNUMTICS = ($TWM_USER + 16)
Global Const $TBM_GETPAGESIZE = ($TWM_USER + 22)
Global Const $TBM_GETPOS = $TWM_USER
Global Const $TBM_GETPTICS = ($TWM_USER + 14)
Global Const $TBM_GETSELEND = ($TWM_USER + 18)
Global Const $TBM_GETSELSTART = ($TWM_USER + 17)
Global Const $TBM_GETRANGEMAX = ($TWM_USER + 2)
Global Const $TBM_GETRANGEMIN = ($TWM_USER + 1)
Global Const $TBM_GETTHUMBLENGTH = ($TWM_USER + 28)
Global Const $TBM_GETTHUMBRECT = ($TWM_USER + 25)
Global Const $TBM_GETTIC = ($TWM_USER + 3)
Global Const $TBM_GETTICPOS = ($TWM_USER + 15)
Global Const $TBM_GETTOOLTIPS = ($TWM_USER + 30)
Global Const $TBM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $TBM_SETBUDDY = ($TWM_USER + 32)
Global Const $TBM_SETLINESIZE = ($TWM_USER + 23)
Global Const $TBM_SETPAGESIZE = ($TWM_USER + 21)
Global Const $TBM_SETPOS = ($TWM_USER + 5)
Global Const $TBM_SETRANGE = ($TWM_USER + 6)
Global Const $TBM_SETRANGEMAX = ($TWM_USER + 8)
Global Const $TBM_SETRANGEMIN = ($TWM_USER + 7)
Global Const $TBM_SETSEL = ($TWM_USER + 10)
Global Const $TBM_SETSELEND = ($TWM_USER + 12)
Global Const $TBM_SETSELSTART = ($TWM_USER + 11)
Global Const $TBM_SETTHUMBLENGTH = ($TWM_USER + 27)
Global Const $TBM_SETTIC = ($TWM_USER + 4)
Global Const $TBM_SETTICFREQ = ($TWM_USER + 20)
Global Const $TBM_SETTIPSIDE = ($TWM_USER + 31)
Global Const $TBM_SETTOOLTIPS = ($TWM_USER + 29)
Global Const $TBM_SETUNICODEFORMAT = 0x2000 + 5

; Tip Side Params
Global Const $TBTS_BOTTOM = 2
Global Const $TBTS_LEFT = 1
Global Const $TBTS_RIGHT = 3
Global Const $TBTS_TOP = 0

; Control default styles
Global Const $GUI_SS_DEFAULT_SLIDER = $TBS_AUTOTICKS