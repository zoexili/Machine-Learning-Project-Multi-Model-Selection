import arcpy,os
from arcpy import env
from arcpy.sa import *
arcpy.CheckOutExtension("Spatial")

env.workspace = r"E:\125_52\New folder_2000-2017"
env.overwriteOutput = True

outworkspace = r"E:\ExtractByMask"

tifflist = arcpy.ListRasters("*125052*2012*sr_band*")
masklist = arcpy.ListRasters("*125052*2012*qa*")
for raster in tifflist:
    rasterName = raster
    rasterMask = ""
    for mask in masklist:
        if mask.startswith(rasterName.split("_")[3], 17, 26) == True:
            rasterMask = mask
            break
    if rasterMask != "":
        outraster = rasterName.replace(".tif","_masked.tif")
        outname = os.path.join(outworkspace,outraster)
        arcpy.gp.ExtractByMask_sa(rasterName,rasterMask,outname)

#arcpy.CheckInExtension("Spatial")
