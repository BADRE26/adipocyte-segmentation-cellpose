// Macro: Automatic_Adipocyte_Segmentation.ijm
// Automated adipocyte segmentation and measurement with Cellpose
// IMPORTANT: calibrate the spatial scale (Analyze > Set Scale..., "Global" checked)
// before running this macro.

// Select a directory containing the images
dir = getDirectory("Choose a directory containing the images");
print("Selected directory: " + dir);

// Get the list of files in the directory
list = getFileList(dir);
print("Number of files found: " + list.length);

// Loop through and process each image in the directory
for (i = 0; i < list.length; i++) {
    imagePath = dir + list[i];
    lowerName = toLowerCase(list[i]);

    // Check whether the file is a valid image
    if (endsWith(lowerName, ".jpg") || endsWith(lowerName, ".png") || endsWith(lowerName, ".tif")) {
        print("Processing: " + imagePath);

        // Reset the ROI Manager and Results table for each image
        roiManager("Reset");
        run("Clear Results");

        // Open the image
        open(imagePath);
        originalTitle = getTitle();
        baseName = File.nameWithoutExtension;

        // Run Cellpose
        run("Cellpose ...",
            "env_path=F:\\WORKK\\cellposeEnv env_type=venv model=cyto2 " +
            "model_path=F:\\WORKK\\to diameter=100 ch1=0 ch2=1 additional_flags=");

        // Select the image produced by Cellpose
        cellposeImage = baseName + "-cellpose";
        selectImage(cellposeImage);

        // Extract the ROIs and measure
        run("Label image to ROIs", "rm=[RoiManager]");
        roiManager("Show All with labels");
        roiManager("Measure");

        // Save the results
        resultFile = dir + baseName + "_results.csv";
        saveAs("Results", resultFile);
        print("Results saved to: " + resultFile);

        // Save the processed image
        saveAs("PNG", dir + cellposeImage + ".png");

        // Close the processed image and the original
        close();
        selectImage(originalTitle);
        close();
    } else {
        print("File skipped: " + list[i]);
    }
}

// Final message
print("Processing complete.");
