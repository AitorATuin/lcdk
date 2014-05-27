module("CDK", package.seeall)
require "CDK"

local cdk, lcdk = CDK.AlienLibraries()

lcdk.__newCDKMatrix:types{
   ret = "pointer",
   "pointer",
   "int","int", "int","int","int","int",
   "string",
   "pointer", "pointer",
   "int","int","int","int","int","int","int","int","int"
}
*newCDKMatrix (
                      CDKSCREEN *cdkscreen,
                      int xpos,
                      int ypos,
                      int screenRows,
                      int screenCols,
                      int actualRows,
                      int actualCols,
                      const char *title,
                      CDK_CONST char **rowTitles,
                      CDK_CONST char **colTitles,
                      int *columnWidths,
                      int *columnTypes,
                      int rowSpace,
                      int colSpace,
                      chtype filler,
                      int dominantAttribute,
                      boolean boxMatrix,
                      boolean boxCell,
                      boolean shadow)

newCDKMatrix(cdkscreen, xpos, ypos, actualRows, actualCols, title)
newCDKMatrix = function(cdkscreen, xpos, ypos, screenRows, screenCols,
                        title, rowTitles, colTitles,
                        columnWidths, columnTypes, rowSpace, colSpace,
                        rowSpace, colSpace, filler, dominantAttribute, boxMatrix,
                        boxCell, shadow)
   local rTitles, rTitlesCount = CDK.TableToString(rowTitles)
   local cTitles, cTitlesCount = CDK.TableToString(colTitles)
   local cWidths, cWidthsCount = CDK.TableToInt(columnWidths)
   local cTypes, cTypesCount = CDK.TableToInt(columnTypes)
   return lcdk.__newCDKMatrix(cdkscreen, xpos, ypos, screenRows, screenCols,
                              title,
   )
end
