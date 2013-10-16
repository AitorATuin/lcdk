module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

cdk.newCDKTemplate:types{
    ret = "pointer",
    "pointer",
    "int",
    "int",
    "string",
    "string",
    "string",
    "string",
    "int",
    "int",
}

newCDKTemplate = cdk.newCDKTemplate

cdk.activateCDKTemplate:types{
    ret = "string",
    "pointer",
    "pointer"
}
activateCDKTemplate = cdk.activateCDKTemplate

destroyCDKTemplate = CDK.destroyCDKObject

