local HOME = os.getenv("HOME")
local LOCALLUAPATH = HOME .. "/.lua/share/?.lua;" .. HOME ..  "/.lua/share/?/?.lua"
package.path = package.path .. ";" .. LOCALLUAPATH

require "luarocks.require"
local Curses = require "Curses".configure()
require "CDK"
require "CDK.Dialog"


local dialogText = [[ CDKDialog example
This is just an example of using CDKDialog
]]
local dialogText = [[<C></U>Dialog Widget Demo

<C>The dialog widget allows the programmer to create
<C>a popup dialog box with buttons. The dialog box
<C>can contain </B/32>colours<!B!32>, </R>character attributes<!R>
<R>and even be right justified.
<L>and left.
]]

local buttons = {
    "Ok",
    "Cancel"
}

Main_Window = Curses.InitCurses()
Height = Curses.GetMaxY(Main_Window)
Width = Curses.GetMaxX(Main_Window)
Curses.NoEcho()
Curses.CursSet(Curses.CURSOR_INVISIBLE)
Curses.KeyPad(InitScr, 1)
Curses.CBreak()
Curses.HalfDelay(3)
Curses.Timeout(0)

CDK_Screen = CDK.initCDKScreen(Main_Window)
CDK.initCDKColor()
Width=1
Height=3
local dialog = CDK.newCDKDialog(CDK_Screen, Width/2, Height/2, dialogText, buttons,
    1234, CDK.TRUE, CDK.TRUE, CDK.FALSE)
local a = CDK.activateCDKDialog(dialog, true)
