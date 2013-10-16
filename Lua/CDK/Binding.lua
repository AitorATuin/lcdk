module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.bindCDKObject:types{
	ret = "void",
	"int",
	"pointer",
	"int",
	"callback",
	"pointer"
}
--bindCDKObject = cdk.bindCDKObject
bindCDKObject = function (a,b,c,d,e)
	return cdk.bindCDKObject(a,b,c,d,e)
end
cdk.cleanCDKObjectBindings:types{
	ret = "void",
	"int",
	"pointer"
}
cleanCDKObjectBindings = cdk.cleanCDKObjectBindings
cdk.checkCDKObjectBind:types{
	ret = "int",
	"int",
	"pointer",
	"int"
} 
checkCDKObjectBind = cdk.checkCDKObjectBind
lcdk._unbindCDKObject:types{
	ret = "void",
	"int",
	"pointer",
	"int"
}
unbindCDKObject = lcdk._unbindCDKObject

newBindFunction = function (func)
	return alien.callback(func, "int", "int", "pointer", "pointer", "int")
end

