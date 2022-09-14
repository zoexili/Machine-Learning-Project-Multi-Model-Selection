# Create lots of empty Mosaic Datasets
import arcpy,os

arcpy.env.workspace = r"E:\Austin\MATCH\QAfolder"
inworkspace = r"E:\Austin_mosaic\QA_mosaic.gdb"
spatialref = "PROJCS['WGS_1984_Albers',GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378140.0,298.257]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Albers'],PARAMETER['false_easting',0.0],PARAMETER['false_northing',0.0],PARAMETER['central_meridian',-96.0],PARAMETER['standard_parallel_1',29.5],PARAMETER['standard_parallel_2',45.5],PARAMETER['latitude_of_origin',23.0],UNIT['Meter',1.0]];-16901100 -6972200 10000;-100000 10000;-100000 10000;0.001;0.001;0.001;IsHighPrecision"

list1 = arcpy.ListRasters("*015016*")

for raster in list1:
    rasterName = raster
    if rasterName != "":        
        mosaic_name = rasterName.replace(".tif", "_mosaic")
        dataset_name = os.path.join(inworkspace,mosaic_name)
        if arcpy.Exists(dataset_name) == False:
            arcpy.CreateMosaicDataset_management(inworkspace, dataset_name, spatialref, '#', '#', 'NONE', '#')