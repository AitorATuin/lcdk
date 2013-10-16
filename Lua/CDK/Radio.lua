module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKRadio:types{
    ret = "pointer",
    "pointer",
    "int",
    "int",
    "int",
    "int",
    "int",
    "string",
    "pointer",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int"
}

newCDKRadio = function (cdkscreen, xpos, ypos, spos, height, width, title,
                        radiolist, choicechar, highlight, defaultitem, box,
                        shadow)
    local rl = ""
    local rlcount = 0
    rl, rlcount = CDK.TableToString(radiolist)
    return lcdk.__newCDKRadio(cdkscreen, xpos, ypos, spos, height, width,
        title, rl, rlcount, choicechar, highlight, defaultitem, box, shadow)
end

cdk.activateCDKRadio:types{
    ret = "int",
    "pointer",
    "pointer"
}

activateCDKRadio = function (itemlist, actions)
    local i = cdk.activateCDKRadio(itemlist, actions)
    if i >= 0 then
        return i + 1
    end
    return i
end

destroyCDKRadio = CDK.destroyCDKObject

