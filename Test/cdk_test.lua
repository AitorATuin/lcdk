package.path = package.path .. ";Lua/?.lua;Lua/?/?.lua"
require "luarocks.require"
require "CDK"
require "Curses"

local main = function (argc, argv)
	local win = Curses.InitCurses()
	local fd = CDK.startCDKDebug("cdk.log")
	CDK.writeCDKDebugMessage("cdk_test.lua", "main", 9, "Iniciando debug")
	local screen = CDK.initCDKScreen(win)
	local screen1 = CDK.initCDKScreen(win)
	local title1 = CDK.toCharDblPtr([[<C><#HL(30)>
<C></R>This is the second screen.
<C>Hit space to go to the next screen
<C><#HL(30)>
]], 4)
	CDK.writeCDKDebugMessage("cdk_test.lua", "main", 28, "creating new CDKLabel en screen ".. tostring(screen))
	local label1 = CDK.newCDKLabel(screen, CDK.CENTER, CDK.TOP, title1, 4, 0, 0)
	local dialogmesg = CDK.toCharDblPtr([[<C><#HL(30)>
<C>Screen 5
<C>This is the last of 5 screens. If you want
<C>to continue press the 'Continue' button.
<C>Otherwise press the 'Exit' button.
<C><#HL(30)>
]], 6)
	local buttons = CDK.toCharDblPtr([[Continue
Exit
]], 2)
	CDK.writeCDKDebugMessage("cdk_test.lua", "main", 28, "creating new CDKDialog en screen ".. tostring(screen1))
	local dialog = CDK.newCDKDialog(screen1, CDK.CENTER, CDK.TOP, dialogmesg,
		6, buttons, 2, 262144, 1, 1, 0)

	CDK.writeCDKDebugMessage("cdk_test.lua", "main", 37, "creado dialog " ..tostring(dialog))
	while (true) do
		CDK.drawCDKScreen(screen)
		CDK.waitCDKLabel(label1, ' ')
		CDK.eraseCDKScreen(screen)
		CDK.drawCDKScreen(screen1)
		CDK.writeCDKDebugMessage("cdk_test.lua", "main", 37, "activating CDKDialog")
		c = CDK.activateCDKDialog(dialog,0)
		if (c == 1) then
			break
		end
	end
	CDK.endCDK()
end

main(#arg, arg)
