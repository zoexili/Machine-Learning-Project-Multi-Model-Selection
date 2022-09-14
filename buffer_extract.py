import arcpy,os
from arcpy import env
from arcpy.sa import *
arcpy.CheckOutExtension("Spatial")

env.workspace = r"E:\Pixel\Centroid_Circles\geotiff"
env.overwriteOutput = True

outworkspace = r"E:\Pixel\Centroid_Circles\buffer_extract"

mask = r"E:\sample_data\buffer.gdb\buf9" #
tifflist = arcpy.ListRasters("*")
for raster in tifflist:
    outraster = raster.replace(".tif","_buf009.tif")  #
    outname = os.path.join(outworkspace,outraster)
    arcpy.gp.ExtractByMask_sa(raster,mask,outname)

#arcpy.CheckInExtension("Spatial")