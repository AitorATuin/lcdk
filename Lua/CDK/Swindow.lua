module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.newCDKSwindow:types{
	ret = "pointer",
	"pointer",
	"int",
	"int",
	"int",
	"int",
	"pointer",
	"int",
	"int",
	"int"
}
newCDKSwindow = cdk.newCDKSwindow
cdk.addCDKSwindow:types{
	ret = "void",
	"pointer",
	"pointer",
	"int"
}
addCDKSwindow = cdk.addCDKSwindow
cdk.activateCDKSwindow:types{
	ret = "void",
	"pointer", "pointer",
}
activateCDKSwindow = cdk.activateCDKSwindow
lcdk._setCDKSwindowBackgroundColor:types{
	ret = "void",
	"pointer", "pointer"
}
--setCDKSwindowBackgroundColor = lcdk._setCDKSwindowBackgroundColor
setCDKSwindowBackgroundColor = function (swindow, color)
	local obj = lcdk._getObj(swindow) 
	cdk.setCDKObjectBackgroundColor(obj, color)
end

