import arcpy,os

basepath = arcpy.env.workspace = r"E:\new_img\big_folder"
lst1 = arcpy.ListRasters("*125052*")
lst2 = arcpy.ListRasters("*125053*")


outworkspace = arcpy.env.workspace = r"E:\Mosaic\mosaic_New.gdb"
arcpy.env.overwriteOutput = True
lst3 = arcpy.ListDatasets()

for raster in lst1:
    rasterName = raster
    partnerName = ""
    datasetName = ""
    for partner in lst2: 
        if partner.split('_')[3] == rasterName.split('_')[3]:
            if partner.split('_')[8] == rasterName.split('_')[8]:  
                partnerName = partner
                break
    for dataset in lst3: 
        if dataset.split('_')[3] == rasterName.split('_')[3]:
            if (dataset.split('_')[8]+'.tif') == rasterName.split('_')[8]:  
                datasetName = dataset
                outname = os.path.normpath(os.path.join(outworkspace, datasetName))              
                ras_path = os.path.normpath(os.path.join(basepath,rasterName))
                par_path = os.path.normpath(os.path.join(basepath,partnerName))
                arcpy.AddRastersToMosaicDataset_management(outname,"Raster Dataset", ras_path + ";" + par_path)