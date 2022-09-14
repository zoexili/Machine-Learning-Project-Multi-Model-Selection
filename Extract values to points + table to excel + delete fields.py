import arcpy,os
from arcpy.sa import *
arcpy.CheckOutExtension("Spatial")
arcpy.env.workspace = "E:/clip_area"
outpath = "E:/Excel/Test"
point_feature = "E:/sample_data/Test.gdb/pnt2002"

# Extract multi values to points + export to excel
rasterlist = arcpy.ListRasters("*125052_20000115*")
ExtractMultiValuesToPoints(point_feature,rasterlist)
outExcel = os.path.join(outpath,"20000115" + ".xls")
arcpy.TableToExcel_conversion(point_feature,outExcel)

# Delete fields
fields = arcpy.ListFields(point_feature,"*clip*","#")
fieldlist = []
for field in fields:
    fieldlist.append(field.name)
arcpy.DeleteField_management(point_feature,fieldlist)
                    
    
    