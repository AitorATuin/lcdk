module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKItemlist:types{
    ret = "pointer",
    "pointer",
    "int",
    "int",
    "string",
    "string",
    "pointer",
    "int",
    "int",
    "int",
    "int",
}
newCDKItemlist = function (cdkscreen, xpos, ypox, title, label, itemlist,
                            defaultitem, box, shadow)
    local il = ""
    local ilcount = 0
    il, ilcount = CDK.TableToString(itemlist)
    return lcdk.__newCDKItemlist(cdkscreen, xpos, ypox, title, label, il,
        ilcount, defaultitem, box, shadow)
end

cdk.activateCDKItemlist:types{
    ret = "int",
    "pointer",
    "pointer"
}
activateCDKItemlist = function (itemlist, actions)
    local i = cdk.activateCDKItemlist(itemlist, actions)
    if i >= 0 then
        return i + 1
    end
    return i
end

destroyCDKItemlist = CDK.destroyCDKObject
