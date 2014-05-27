module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.newCDKFselect:types{
   ret = "pointer",
   "pointer",
   "int",
   "int",
   "int",
   "int",
   "pointer",
   "pointer",
   "int",
   "int",
   "int",
   "pointer",
   "pointer",
   "pointer",
   "pointer",
   "int",
   "int",
}
newCDKFselect = cdk.newCDKFselect

lcdk.__drawCDKFselect:types{
   ret = "void",
   "pointer", "int"
}
drawCDKFselect = lcdk.__drawCDKFselect

lcdk._activateCDKFselect:types{
   ret = "string",
   "pointer",
   "pointer"
}
activateCDKFselect = lcdk._activateCDKFselect

cdk.setCDKFselect:types{
   ret = "void",
   "pointer",
   "pointer",
   "int",
   "int",
   "int",
   "pointer",
   "pointer",
   "pointer",
   "pointer",
   "int",
}
setCDKFselect = cdk.setCDKFselect

destroyCDKFselect = function (obj)
   cdk._destroyCDKObject(obj)
end
