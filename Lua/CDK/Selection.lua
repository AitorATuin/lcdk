module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKSelection:types{
    ret = "pointer",    -- CDKSelection
    "pointer",
    "int",              -- xpos
    "int",              -- ypos
    "int",
    "int",
    "int",
    "string",
    "pointer",
    "int",
    "pointer",
    "int",
    "int",
    "int",
    "int"
}
newCDKSelection = function (cdkscreen, xpos, ypox, spos, height, width, title,
                            slist, clist, highlight, box, shadow)
    local selectionlist = ""
    local selectionlistlength = 0
    local choicelist = ""
    local choicelistlength = 0
    selectionlist, selectionlistlength = CDK.TableToString(slist)
    choicelist, choicelistlength = CDK.TableToString(clist)
    return lcdk.__newCDKSelection(cdkscreen, xpos, ypox, spos, height, width, 
        title, selectionlist, selectionlistlength, choicelist, 
        choicelistlength, highlight, box, shadow)
end

lcdk.__CDKSelectionGetListSize:types{
    ret = "int",
    "pointer"
}
lcdk.__CDKSelectionGetSelection:types{
    ret = "int",
    "pointer", "int"
}

cdk.activateCDKSelection:types{
    ret = "int",
    "pointer",
    "pointer",
}
activateCDKSelection = function (selection, actions)
    local t = {}
    cdk.activateCDKSelection(selection, actions)
    for i=0, lcdk.__CDKSelectionGetListSize(selection) - 1 do
        t[i+1] = lcdk.__CDKSelectionGetSelection(selection, i)
    end
    return t
end

destroyCDKSelection = CDK.destroyCDKObject
