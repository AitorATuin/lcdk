module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKLabel:types{
   ret = "pointer",
   "pointer", "int", "int", "pointer", "int", "int", "int"
}
newCDKLabel = lcdk.__newCDKLabel
cdk.waitCDKLabel:types{
   ret = "char",
   "pointer", "char"
}
waitCDKLabel = cdk.waitCDKLabel
lcdk.__drawCDKLabel:types{
   ret = "void",
   "pointer", "int"
}
drawCDKLabel = lcdk.__drawCDKLabel
setCDKLabelBackgroundColor = function (w, color)
	local obj = lcdk._getObj(w)
	cdk.setCDKObjectBackgroundColor(obj, color)
end
lcdk.__setCDKLabel:types{
   ret = "void",
   "pointer",
   "pointer",
   "int",
   "int"
}
setCDKLabel = lcdk.__setCDKLabel
