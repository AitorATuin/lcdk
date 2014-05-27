local M = {}
local M_bindings
require "luarocks.require"
local mkModule = require "MkModule"
local alien = require "alien"
local struct = require "CDK.struct"
local alienize = require "CDK.alienize"

-- Initialize CDK library
local function initCDK (L)
   local cdk = L.cdk
   cdk.initCDKScreen:types(
      {
         ret = "void",
         "pointer"
   })
   cdk.endCDK:types(
      {
         ret = "void"
   })
end

-- Initialize module
local init = function (L)
end

M_bindings = {
   cdk = {
      initCDKScreen = {
         ret = "void", "pointer"
      },
      endCDK = { ret = "void" }
   }
}

local moduleConf = {
   configure = configure,
   init = init,
   libraries = {
      {
         name = "cdk",
         libname = "cdk"
      },
      {
         env = "LCDKSO",
         name = "liblcdk",
         libname = "liblcdk.so"
      }
   },
   methods = M,
   bindings = M_bindings
}
return mkModule.make(modulesonf)

--[[
    * Function to implement here

    destroyCDKScreen
    endCDK
    eraseCDKScreen
    initCDKColor
    initCDKScreen
    lowerCDKObject
    raiseCDKObject
    refreshCDKScreen
    registerCDKObject
    unregisterCDKObject
--]]

--[[local cdk = alien.load("cdk")
local lcdk, err = alienize("liblcdk.so", "LCDKSO")
if not lcdk then
    error(string.format("Could not load liblcdk.so library: %s", err))
end

local DEBUGFD

TRUE = 1
FALSE = 0

-- TODO
-- Add A_constants
A_REVERSE = 262144

-- functions  {{{
function AlienLibraries ()
    return cdk, lcdk
end


function TableToString (table) -- {{{
    local str = ""
    local n = 0
    for _, r in ipairs(table) do
        str = str .. r .. "\n"
        n = n + 1
    end
    return str, n
end --}}}

function StringToString (string) -- {{{
    local str = ""
    local n = 0
    for c in string:gmatch(".") do
        if c == '\n' then
            n = n + 1
        end
    end
    return string,n
end -- }}}

function PrepareString (str)
    local s, n
    if type(str) == "table" then
        s, n = TableToString(str)
    elseif type(str) == "string" then
        s, n = StringToString(str)
    else
        return nil
    end
    return CDK.toCharDblPtr(s, n), n
end
-- }}}
--
-- CDKOBJS {{{
local CDKOBJS = struct.defStruct{
	{"screenIndex", "int"},
	{"screen", "pointer"},
	{"fn", "pointer"},
	{"box", "int"},
	{"borderSize", "int"},
	{"acceptsFocus", "int"},
	{"hasFocus", "int"},
	{"isVisible", "int"},
	{"inputWindow", "pointer"},
	{"dataPtr", "pointer"},
	{"resultData", "double"},
	{"bindingCount", "uint"},
	{"bindingList", "pointer"},
	{"title", "pointer"},
	{"titlePos", "pointer"},
	{"titleLen", "pointer"},
	{"titleLines", "int"},
	{"ULChar", "int"},
	{"URChar", "int"},
	{"LLChar", "int"},
	{"LRChar", "int"},
	{"VTChar", "int"},
	{"HZChar", "int"},
	{"BXAttr", "int"},
	{"exitType", "int"},
	{"earlyExit", "int"},
	{"preProcessFunction", "callback"},
	{"preProcessData", "pointer"},
	{"postProcessFunction", "callback"},
	{"postProcessData", "pointer"},
} -- }}}
-- cdk interfaces {{{
-- Basic CDK {{{

cdk.endCDK:types{
	ret = "void"
}
endCDK = cdk.endCDK

cdk.initCDKColor:types{
	ret = "void"
}
initCDKColor = cdk.initCDKColor
cdk.startCDKDebug:types{
	ret = "pointer",
	"pointer"
}
lcdk._getObj:types{
	ret = "pointer",
	"pointer"
}
getObj = lcdk._getObj
lcdk._screenOf:types{
	ret = "pointer",
	"pointer"
}
screenOf = lcdk._screenOf
cdk.setCDKObjectBackgroundColor:types{
	ret = "void",
	"pointer",
	"pointer"
}
cdk.popupLabel:types{
	ret = "void",
	"pointer", "pointer", "int"
}
popupLabel = cdk.popupLabel
cdk._destroyCDKObject:types{
	ret="void", "pointer"
}
destroyCDKObject = cdk._destroyCDKObject

-- }}}
-- CDK Screen {{{
cdk.initCDKScreen:types{
	ret = "pointer",
	"pointer"
	-- CDKSCREEN *, WINDOW *
}
initCDKScreen = cdk.initCDKScreen
cdk.drawCDKScreen:types{
	ret = "void",
	"pointer"
}
drawCDKScreen = cdk.drawCDKScreen
cdk.eraseCDKScreen:types{
	ret = "void",
	"pointer"
}
eraseCDKScreen = cdk.eraseCDKScreen
-- }}}
-- TODO:
-- Fix this.
-- Initialization needed because of how CDK reallocs memory
-- see CDKreadFile and CDKallocStrings in cdk.c
CDKFileContent = struct.defStruct{
	{"info", "pointer"},
	{"lines", "int"}
}
lcdk._CDKReadFile:types{
	ret = "int",
	"pointer", "pointer"
}
CDKreadFile = lcdk._CDKReadFile
setCDKViewerBackgroundColor = function (w, color)
	local obj = lcdk._getObj(w)
	cdk.setCDKObjectBackgroundColor(obj, color)
end
--[[cdk.CDKreadFile:types{
	ret = "int",
	"pointer",
	"pointer"
}
CDKreadFile = cdk.CDKreadFile--]]
--[[
-- }}}
-- }}}-- end cdk interfaces }}}
-- lcdk {{{
-- TODO: create a wrapper to capture n (int)
lcdk.toCharDblPtr:types{
	ret = "pointer",
	"pointer", "int"
}
toCharDblPtr = lcdk.toCharDblPtr
lcdk.toCharPtr:types{
	ret = "pointer",
	"pointer", "int"
}
toCharPtr = lcdk.toCharPtr

lcdk._color_pair:types{
	ret = "pointer",
	"int"
}
COLOR_PAIR = lcdk._color_pair
-- end lcdk }}}
-- lua functions {{{
startCDKDebug = function (file)
	local f = file or "/tmp/lcdk.log"
	DEBUGFD, err = io.open(f, "w")
	if not DEBUGFD then
		return nil, "Unable to open " .. f
	end
	return true
end

writeCDKDebugMessage = function (file, func, line, msg)
	DEBUGFD:write(string.format("%s::%s (Line %d) %s\n", file, func, line, msg))
	DEBUGFD:flush()
end

stopCDKDebug = function ()
	DEBUGFD:close()
end--]]
-- }}}
-- vi: set foldmethod=marker foldlevel=0:
