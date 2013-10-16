module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.newCDKViewer:types{
	ret = "pointer",
	"pointer", 
	"int",
	"int",
	"int",
	"int",
	"pointer",
	"int",
	"int",
	"int",
	"int",
}
newCDKViewer = cdk.newCDKViewer
cdk.activateCDKViewer:types{
	ret = "int",
	"pointer"
}
activateCDKViewer = cdk.activateCDKViewer
cdk.setCDKViewer:types{
	ret = "void",
	"pointer",
	"pointer",
	"pointer",
	"int",
	"int",
	"int",
	"int",
	"int",
}
setCDKViewer = cdk.setCDKViewer

