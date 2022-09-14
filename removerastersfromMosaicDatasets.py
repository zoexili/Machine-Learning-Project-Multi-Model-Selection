import arcpy
arcpy.env.workspace = r"E:\Mosaic\mosaic_datasets.gdb"
lst = arcpy.ListDatasets()
query = "#"
updatebnd = "#"
markovr = "#"
delovr = "#"
delitemcache = "#"
removeitem = "REMOVE_MOSAICDATASET_ITEMS"
updatecs = "#"
for ras in lst:
    arcpy.RemoveRastersFromMosaicDataset_management(ras,query, updatebnd, markovr, delovr, delitemcache, 
     removeitem, updatecs)