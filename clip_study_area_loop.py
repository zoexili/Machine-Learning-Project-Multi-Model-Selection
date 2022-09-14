# extract by mask to study area
import arcpy,os
from arcpy import env
from arcpy.sa import *
arcpy.CheckOutExtension("Spatial")
env.snapRaster = "E:/Austin_mosaic/austin_snap"
env.workspace = "E:/Austin_mosaic/QA_mosaic.gdb"
outworkspace = "E:/Austin_mosaic/Austin_QAclip.gdb"
mask = "E:/Austin_mosaic/austin_snap"

mosaic_list = arcpy.ListDatasets()
for raster in mosaic_list:
    outraster = raster.replace("mosaic", "clip")
    outname = os.path.join(outworkspace,outraster)
    arcpy.gp.ExtractByMask_sa(raster,mask,outname)
