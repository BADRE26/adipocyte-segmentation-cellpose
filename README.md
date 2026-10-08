# Automatic Adipocyte Segmentation with Cellpose (Fiji/ImageJ) 

## Description
This ImageJ macro (`Automatic_Adipocyte_Segmentation.ijm`) automates the
segmentation of adipocytes on a batch of images using Cellpose.
For each image in a folder, the macro:
1. opens the image;
2. runs Cellpose segmentation (`cyto2` model);
3. converts the label image into ROIs in the ROI Manager;
4. measures each ROI (area, perimeter, etc.);
5. saves the results as a CSV file and the segmented image as a PNG.

The ROI Manager and the Results table are reset for each image, so each
CSV file contains only the measurements of its corresponding image.

## Important note: scale calibration
This macro must be run **only after the spatial scale has been calibrated**
in ImageJ using the scale bar of the images. Otherwise, all measurements
will be expressed in pixels instead of real units (e.g. µm).

## Requirements
- **Fiji** (ImageJ): https://fiji.sc
- **PTBIOP plugin** (provides the `Cellpose ...` command):
  enable the *PTBIOP* update site via `Help > Update... > Manage update sites`
- **MorphoLibJ** or equivalent for `Label image to ROIs`
  (*IJPB-plugins* update site)
- **Python environment with Cellpose** installed (here a `venv`)

## Configuration
Before first use, adjust the following parameters in the macro:

| Parameter    | Current value              | Description                                      |
|--------------|----------------------------|--------------------------------------------------|
| `env_path`   | `F:\WORKK\cellposeEnv`     | Path to the Cellpose Python environment          |
| `env_type`   | `venv`                     | Environment type (`venv` or `conda`)             |
| `model`      | `cyto2`                    | Cellpose model used                              |
| `diameter`   | `100`                      | Estimated mean adipocyte diameter (in pixels)    |
| `ch1`, `ch2` | `0`, `1`                   | Channels used for segmentation                   |

## Usage
1. Make sure the spatial scale has been calibrated using the scale bar (see note above).
2. Open Fiji.
3. Go to `Plugins > Macros > Run...` and select `Automatic_Adipocyte_Segmentation.ijm`.
4. Choose the folder containing the images.
5. Wait for the "Processing complete." message in the Log window.

Supported formats: `.jpg`, `.png`, `.tif` (upper or lower case).
Other files are skipped.

## Output files
For an image named `sample1.jpg` (or `sample1.png`, `sample1.tif`),
the macro creates in the same folder:
- `sample1_results.csv`: measurements of each adipocyte
- `sample1-cellpose.png`: segmented label image

## Authors
Ouafa Badre, Sue-Ling Chang, Belkacem Abdous, Julie Lemieux,
Francine Durocher, André Tchernof, Caroline Diorio

## Contact (Corresponding Author)
**Caroline Diorio, Ph.D.**
Department of Social and Preventive Medicine, Université Laval
Cancer Research Centre, Oncology Research Program
CHU de Québec–Université Laval Research Center
Deschênes-Fabia Breast Disease Centre, Saint-Sacrement Hospital
1050, Chemin Ste-Foy, Room J0-16
Quebec City, QC G1S 4L8, Canada
Email: caroline.diorio@crchudequebec.ulaval.ca
Phone: +1-418-682-7511 ext. 84726

Last updated: October 2026

## Citation
If you use this tool, please cite Cellpose:
Stringer, C., Wang, T., Michaelos, M., & Pachitariu, M. (2021).
Cellpose: a generalist algorithm for cellular segmentation. *Nature Methods*, 18, 100–106.
