module("CDK", package.seeall)

require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKDialog:types{
	ret = "pointer",
	"pointer", "int", "int", "pointer", "int", "pointer", "int", "int", "int", "int", "int"
}
newCDKDialog = function (cdkscreen, xpos, ypos, message, buttons, highlight, 
                            separator, box, shadow)
    local msg = ""
    local nmsg = 0
    local btns = ""
    local nbtns = 0
    if type(message) == "table" then
        msg, nmsg = CDK.TableToString(message)
    elseif type(message) == "string" then
        msg, nmsg = CDK.StringToString(message)
    else
        error("Bad message argument, expected table or string")
    end

    if type(buttons) == "table" then 
        btns, nbtns = CDK.TableToString(buttons)            
    elseif type(buttons) == "string" then
        btns, nbtns = CDK,StringToString(buttons)
    else
        error("Bad buttons argument, expected table or string")
    end
    
    return lcdk.__newCDKDialog(cdkscreen, xpos, ypos, msg, nmsg, btns, nbtns, highlight,
        separator, box, shadow)
end 

cdk.activateCDKDialog:types{
	ret = "int",
	"pointer", "int"
}
activateCDKDialog = cdk.activateCDKDialog
setCDKDialogBackgroundColor = function (w, color)
	local obj = cdkwrp._getObj(w) 
	cdk.setCDKObjectBackgroundColor(obj, color)
end
