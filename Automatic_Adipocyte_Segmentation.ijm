// Macro: Automatic_Adipocyte_Segmentation.ijm
// Developed for automated adipocyte analysis with Cellpose
 
// Select a directory containing the images
dir = getDirectory("Choose a directory containing the images");
print("Selected directory: " + dir);
 
// Get the list of files in the directory
list = getFileList(dir);
print("Number of images found: " + list.length);
 
// Initialize the RoiManager
roiManager("Reset");
 
// Loop through and process each image in the directory
for (i = 0; i < list.length; i++) {
    imagePath = dir + list[i];
 
    // Check whether the file is a valid image
    if (endsWith(imagePath, ".jpg") || endsWith(imagePath, ".png") || endsWith(imagePath, ".tif")) {
        print("Processing: " + imagePath);
 
        // Open the image
        open(imagePath);
 
        // Run Cellpose
        run("Cellpose ...",
            "env_path=F:\\WORKK\\cellposeEnv env_type=venv model=cyto2 " +
            "model_path=F:\\WORKK\\to diameter=100 ch1=0 ch2=1 additional_flags=");
 
        // Select the image processed by Cellpose
        cellposeImage = list[i].replace(".jpg", "-cellpose");
        selectImage(cellposeImage);
 
        // Extract the ROIs and measure
        run("Label image to ROIs", "rm=[RoiManager]");
        roiManager("Show All");
        roiManager("Show All with labels");
        roiManager("Measure");
 
        // Save the results with a unique name
        resultFile = dir + list[i].replace(".jpg", "_results.csv");
        saveAs("Results", resultFile);
        print("Results saved to: " + resultFile);
 
        // Save the processed image
        saveAs("PNG", dir + cellposeImage + ".png");
 
        // Close the processed image and the original
        run("Close");
        selectImage(list[i]);
        run("Close");
    } else {
        print("File skipped: " + list[i]);
    }
}
 
// Final message
print("Processing complete.");
