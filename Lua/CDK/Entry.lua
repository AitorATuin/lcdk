module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.newCDKEntry:types{
	ret = "pointer",
	"pointer",
	"int",
	"int",
	"pointer",
	"pointer",
	"int",
	"int",
	"int",
	"int",
	"int",
	"int",
	"int",
	"int",
}
newCDKEntry = cdk.newCDKEntry

cdk.activateCDKEntry:types{
    ret = "string",
    "pointer", "int"
}
activateCDKEntry = cdk.activateCDKEntry

destroyCDKEntry = CDK.destroyCDKObject

