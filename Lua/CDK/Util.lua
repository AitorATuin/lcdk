module("CDK", package.seeall)
require "luarocks.require" 
require "CDK"
require "alien"


local cdk, lcdk = CDK.AlienLibraries()

cdk.popupDialog:types{
    ret = "int",
    "pointer", "pointer", "int", "pointer", "int"
}

popupDialog = function (cdkscreen, msg, buttons)
    local m, mn = PrepareString(msg)
    local b, bn = PrepareString(buttons)
    return cdk.popupDialog(cdkscreen, m, mn, b, bn)

end
